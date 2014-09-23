//
//  file_unix.c
//
//  Created by Wanqiang Ji on 9/23/14.
//  Copyright (c) 2014 Sina Inc. All rights reserved.
//
//  Resolved the problem that LLVM compile the project in x86 environment.
//    "_fwrite$UNIX2003", referenced from: Symbol(s) not found for architecture i386
//  Reference:
//

#include <stdio.h>

FILE* fopen$UNIX2003(const char *filename, const char *mode)
{
    return fopen(filename, mode);
}

size_t fwrite$UNIX2003(const void *a, size_t b, size_t c, FILE *d)
{
    return fwrite(a, b, c, d);
}
