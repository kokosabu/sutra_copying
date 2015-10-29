void squeeze(char s[], int c)
{
    int i, j;

    for (i = j = 0; s[i] != '\0'; i++)
        if ([i] != c)
            s[j++] = s[i];
    s[j] = '\0';
}
