#!/bin/sh
javac com/stackoverflow/q3732109/MinimalHTTP.java
jar -cmvf MANIFEST.MF MinimalHTTP.jar com/stackoverflow/q3732109/*.class
java -jar MinimalHTTP.jar