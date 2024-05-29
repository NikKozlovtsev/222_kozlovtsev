#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <regex.h>

char* replaceregex(const char* pattern, const char* text, const char* replacement) {
    regex_t regex;
    regmatch_t pmatch[1];
    const char *p = text;
    char *res = NULL;
    size_t resLen = 0;
    size_t resCap = 1024;
    size_t pattern_len = strlen(pattern);
    size_t repLen = strlen(replacement);

    res = (char*)malloc(resCap);
    if (!res)
    {
        printf("memory alloc failed\n");
        exit(1);
    }
    res[0] = '\0';
    if (regcomp(&regex, pattern, REG_EXTENDED)) {
        printf("Couldnt compile reg\n");
        exit(1);
    }
    while (regexec(&regex, p, 1, pmatch, 0) == 0) {
        size_t matchStart = pmatch[0].rm_so;
        size_t matchEnd = pmatch[0].rm_eo;
        size_t text_len = strlen(p);
        if (resLen + matchStart + repLen >= resCap) {
            resCap *= 2;
            res = (char*)realloc(res, resCap);
            if (!res) {
                printf("memory realloc failed:(\n");
                exit(1);
            }
        }
        strncat(res, p, matchStart);
        resLen += matchStart;
        strcat(res, replacement);
        resLen += repLen;

        p += matchEnd;
    }
    strcat(res, p);
    resLen += strlen(p);
    regfree(&regex);
    return res;
}

int main(int argc, char *argv[])
{
    if (argc != 4)
    {
        printf("%s", argv[0]);
        return 1;
    }
    const char *pattern = argv[1];
    const char *text = argv[2];
    const char *replacement = argv[3];
    char *res = replaceregex(pattern, text, replacement);
    printf("Upd txt: %s\n", res);
    free(res);
    return 0;
}