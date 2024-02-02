/* See LICENSE file for copyright and license details. */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <sys/wait.h>

int main(void) {
    int nPkgs = 20;
    
    char **pkgs = calloc(nPkgs, sizeof(char*));

    if (pkgs == NULL) {
        fprintf(stderr, "Memory allocation failed\n");
        return EXIT_FAILURE;
    }

    int n = 0;
    pkgs[n] = strdup("sudo");
    pkgs[++n] = strdup("nala");
    pkgs[++n] = strdup("install");
    pkgs[++n] = strdup("-y");
    pkgs[++n] = strdup("curl");
    pkgs[++n] = strdup("dbus-x11");
    pkgs[++n] = strdup("dunst");
    pkgs[++n] = strdup("feh");
    pkgs[++n] = strdup("firefox-esr");
    pkgs[++n] = strdup("gimp");
    pkgs[++n] = strdup("light");
    pkgs[++n] = strdup("network-manager");
    pkgs[++n] = strdup("npm");
    pkgs[++n] = strdup("picom");
    pkgs[++n] = strdup("unclutter-xfixes");
    pkgs[++n] = strdup("unzip");
    pkgs[++n] = strdup("wireplumber");
    pkgs[++n] = strdup("xclip");
    pkgs[++n] = strdup("zathura");
    pkgs[++n] = (char *) NULL;

    for (int i = 0; i < nPkgs-1; ++i) {
        if (pkgs[i] == NULL) {
            fprintf(stderr, "Memory allocation for string %d failed\n", i + 1);
            for (int j = 0; j < i; ++j) {
                free(pkgs[j]);
            }
            free(pkgs);
            return EXIT_FAILURE;
        }
    }

    printf("Sudo privileges are required for packages installation.\n");
    pid_t p = fork();
    if (p == 0) {
        printf("sudo apt-get install -y nala\n");
        execlp("sudo", "sudo", "apt-get", "install", "-y", "nala", (char *) NULL);
    }
    wait(NULL);
    p = fork();
    if (p == 0) {
        printf("sudo nala install -y ...\n");
        execvp("sudo", pkgs);
    }
    wait(NULL);

    for (int i = 0; i < nPkgs; ++i) {
        free(pkgs[i]);
    }
    free(pkgs);

    return EXIT_SUCCESS;
}
