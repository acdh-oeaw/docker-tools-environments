#!/usr/bin/env python

import os
import time
import subprocess
import shutil


SOURCE_FOLDER = '/dropzone/' #base folder with all customer`s mounted disks
DEST_FOLDER = '/data/' #base folder with folders per customer with jp2 images
SLEEP_TIME = 60 #seconds between reinvocation of this script
SAFE_TIME = 30 #seconds after uploaded file can be manipulated
ALLOWED_IMG_TYPES = ['image/tiff', 'image/jpeg']

while True:
        errors = []

        #scan for source images
        source_images = []

        for root, dirs, files in os.walk(SOURCE_FOLDER, topdown=False):
                for name in dirs:
                        folder_path = os.path.join(root, name).replace(SOURCE_FOLDER, DEST_FOLDER)
                        #check (and eventually fix it) if dest folder has same subfolder structure as source folder
                        if not os.path.exists(folder_path):
                                os.makedirs(folder_path)

                for name in files:
                        full_filepath = os.path.join(root, name)
                        filepath, extension = os.path.splitext(full_filepath.replace(SOURCE_FOLDER, '')) #path (without base folder) and file extension

                        try:
                                img_type = subprocess.check_output(['file', '-b', '--mime-type', full_filepath], stderr=open(os.devnull, 'wb')).strip()
                        except:
                                errors.append('Wrong file type - file "%s"' % full_filepath)
                                continue

                        if img_type in ALLOWED_IMG_TYPES:
                                modified = os.path.getmtime(full_filepath)

                                if time.time() - SAFE_TIME > modified:
                                        source_images.append([filepath, modified, extension, img_type])
                        else:
                                errors.append('Not allowed IMG type - file "%s"' % full_filepath)

        #scan for .jp2 images
        jp2_images = []

        for root, dirs, files in os.walk(DEST_FOLDER, topdown=False):
                for name in files:
                        full_filepath = os.path.join(root, name)
                        filepath = os.path.splitext(full_filepath.replace(DEST_FOLDER, ''))[0]
                        jp2_images.append(filepath)

        #check for added or updated images
        for img in source_images:
                if (not img[0] in jp2_images) or (os.path.getmtime(DEST_FOLDER + img[0] + '.jp2') < img[1]):
                        try:
                                if img[3] != 'image/tiff':
                                        subprocess.call(['djpeg', '-pnm', '-outfile', '%s.ppm' % os.path.join(DEST_FOLDER, img[0]), os.path.join(SOURCE_FOLDER, img[0]) + img[2]], stderr=open(os.devnull, 'wb'))
                                        extension = 'ppm'
                                else:
                                        shutil.copy(os.path.join(SOURCE_FOLDER, img[0]) + img[2], os.path.join(DEST_FOLDER, img[0]) + '.tif')
                                        extension = 'tif'

                                subprocess.call(['kdu_compress', '-i', '%s.%s' % (os.path.join(DEST_FOLDER, img[0]), extension), '-o', '%s.jp2' % os.path.join(DEST_FOLDER, img[0]), '-rate', '0.5', 'Clayers=1', 'Clevels=7', 'Cprecincts={256,256},{256,256},{256,256},{128,128},{128,128},{64,64},{64,64},{32,32},{16,16}', 'Corder=RPCL', 'ORGgen_plt=yes', 'ORGtparts=R', 'Cblk={64,64}', 'Cuse_sop=yes', '-quiet'], stderr=open(os.devnull, 'wb'))
                        except:
                                errors.append('Can`t convert image "%s"' % full_filepath)

                                try:
                                        os.remove('%s.jp2' % os.path.join(DEST_FOLDER, img[0]))
                                except:
                                        errors.append('Can`t delete temporary jp2 file "%s.jp2"' % os.path.join(DEST_FOLDER, img[0]))

                        if img[3] != 'image/tiff':
                                try:
                                        os.remove('%s.ppm' % os.path.join(DEST_FOLDER, img[0]))
                                except:
                                        errors.append('Can`t delete temporary ppm file "%s.ppm"' % os.path.join(DEST_FOLDER, img[0]))
                        else:
                                try:
                                        os.remove('%s.tif' % os.path.join(DEST_FOLDER, img[0]))
                                except:
                                        errors.append('Can`t delete temporary tif file "%s.tif"' % os.path.join(DEST_FOLDER, img[0]))

        for error in errors:
                print error

        time.sleep(SLEEP_TIME)



