#A simple package to upload and download documents in the application.
## This is a configurable package and the application can configure of they want to store files in amazon(key required), their local file system or use gridfs
#Suppport for dashboard added and some templates added and file description added
### In future, we shall keep on adding support for various cloud based libraries and storage options

#Usage

The package provides you with 3 collections:
* systemFiles - The collection which will be used if the package is initialized with filesystem option. The files will be stored in /var/www/systemFiles folder.
* gridFiles - If the package is initialized with gridfs option, the files will be stored in gridfs
* s3Files - These files will be stored in the amazon s3 bucket as provided by the app designer.

Invoke the following function in the server startup routine to configure the application.

initDMS(mode,options)

mode = 1 -> systemFiles
mode = 2 -> gridFiles
mode = 3 -> s3Files

options should be an object , (as of now only applicable in mode 3 which would specify s3 specific options and a blank object in other 2 cases)


#Options for S3

The options for S3 should be specified in the settings file and environment variables.
A sample settings file (run meteor using --settings settings.json) 
{
	 "bucket":"***",
  "accessKeyId":"***",
  "secretAccessKey":"***",
  "folder":"***",
  "region":"***"
}

