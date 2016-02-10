//
//  wcwidth.h
//  liteterm
//
//  Created by yjroot on 2016. 2. 10..
//  Copyright © 2016년 Liteterm Team. All rights reserved.
//

#ifndef wcwidth_h
#define wcwidth_h

#include <wchar.h>

int mk_wcwidth(wchar_t ucs);
int mk_wcswidth(const wchar_t *pwcs, size_t n);
int mk_wcwidth_cjk(wchar_t ucs);
int mk_wcswidth_cjk(const wchar_t *pwcs, size_t n);

#endif /* wcwidth_h */
