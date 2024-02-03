/* See LICENSE file for copyright and license details. */

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <unistd.h>
#include <string.h>
#include <sys/wait.h>

#include "config.h"

/* function declarations */
void installpackages(void);

/* variables */

/* function implementations */
void
installpackages(void)
{
    int npkgs = sizeof(packages) / sizeof(char*);
    char *cmd[npkgs + 5];

    cmd[0] = "sudo";
    cmd[1] = "apt-get";
    cmd[2] = "install";
    cmd[3] = "-y";
    cmd[npkgs + 4] = (char*)NULL;
    
    for (int i = 0; i < npkgs; i++) {
        int size = strlen(packages[i]) * sizeof(char) + 1;

        cmd[i + 4] = (char*) malloc(size);
        if (cmd[i + 4] == NULL) {
            perror("malloc");
            exit(EXIT_FAILURE);
        }
        strcpy(cmd[i + 4], packages[i]);
    }

    printf("Sudo privileges are required for packages installation.\n");
    execvp(cmd[0], cmd);
}


int 
main(void)
{
    pid_t p = fork();
    if (p == 0) {
        installpackages();
    }
    wait(NULL);

    return EXIT_SUCCESS;
}
