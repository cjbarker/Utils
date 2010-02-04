/* *****************************************************************************
 * Dos2Unix is a utility to convert file from DOS line break format to UNIX
 * and vice versa.
 *
 * Author: CJ Barker
 * Date:   02/04/2010
 * *****************************************************************************/

#include <stdio.h>

/* globals */
#define FILE_SUFFIX ".d2u"
enum Conversion { unix, windoze };

void usage() 
{
	printf("\nUsage: dos2unix <file> -u | -w\n");
	printf("\t<file>\tAbsolute file path of file to convert\n");
	printf("\t-u\tConverts file to Unix format\n");
	printf("\t-w\tConverts file to Windows format\n");
	printf("\t-?\tDisplays this usage message\n");
}

int file_exist(const char *filename)
{
	FILE * pFile;
	if (pFile = fopen(filename, "r")) {
		fclose(pFile);
        return 1;
    }
    return 0;
}

int covert_file(const char *filename, enum Conversion type)
{
	FILE * pReadFile;
	FILE * pWriteFile;

	char *writeFilename;
	writeFilename = (char *)malloc(strlen(filename)+strlen(FILE_SUFFIX)+1);
	strcpy(writeFilename, filename);
	strcat(writeFilename, FILE_SUFFIX);
	
	if (writeFilename == NULL) {
		printf("Failed to allocate memory for temporary file name\n");
		return 1;
	}

	if ( !(pWriteFile = fopen(writeFilename, "w")) ) {
		printf("Cannot open file for writing: %s\n", writeFilename);
		return 2;
	}

	if (pReadFile = fopen(filename, "r") ) 
	{
		char ch;
		char prevChar = ' ';

		while ( 1 )
        {
			ch = fgetc(pReadFile);

			if ( ch == EOF )
				break ;

			if (type == unix && ch == '\r') {
				ch = fgetc(pReadFile);
				if (ch == '\n') {
					//printf("HIT carriage return\n");
					fputc((int)'\n', pWriteFile);
				}
			}
			else if (type == windoze && ch == '\n' && prevChar != '\r') {
				//printf("Created carriage return\n");
				fputc((int)'\r', pWriteFile);
				fputc((int)'\n', pWriteFile);
			}
			else {
				fputc((int)ch, pWriteFile);
			}

			prevChar = ch;
        }

		fclose(pReadFile);
		fclose(pWriteFile);

		if (remove(filename) != 0) {
			printf("Failed to delete original file\n");
			return 3;
		}
		if (rename(writeFilename, filename) != 0) {
			printf("Failed to rename temp file\n");
			return 4;
		}

		printf("File successfully converted.\n");
		return 0;
    }
	else {
		printf("Cannot open file: %s\n", filename);
		return 5;
	}
}

int main(int argc, char **argv) 
{
	int i;
	char *filename;
	enum Conversion conversion_type;

	if (argc == 1 || argc < 3) {
		usage();
		return 1;
	}

	/* load and check valid file exists */
	if (!file_exist(argv[1])) {
		printf("File does not exist or cannot be open for reading: %s\n", argv[1]);
		return 2;
	}

	/* validate conversion type */
	if ( (strcmp(argv[2], (char*)"-u")) == 0)
		conversion_type = unix;
	else if ( (strcmp(argv[2], (char*)"-w")) == 0)
		conversion_type = windoze;
	else {
		usage();
		return 3;
	}

	return covert_file(argv[1], conversion_type);
}