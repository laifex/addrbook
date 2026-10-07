#include <stdio.h>
#include "storage.h"

int storage_save(const Book *b, const char *path)
{
    FILE *fp = fopen(path, "w");
    if (fp == NULL)
        return -1;

    for (int i = 0; i < b->count; i++)
    {
        fprintf(fp, "%s %s\n", b->items[i].name, b->items[i].phone);
    }
    fclose(fp);
    return 0;
}

int storage_load(Book *b, const char *path)
{
    FILE *fp = fopen(path, "r");
    if (fp == NULL)
        return -1;

    book_init(b);
    char name[NAME_LEN];
    char phone[PHONE_LEN];
    while (fscanf(fp, "%31s %15s", name, phone) == 2)
    {
        book_add(b, name, phone);
    }
    fclose(fp);
    return 0;
}
