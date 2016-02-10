//
//  Use this file to import your target's public headers that you would like to expose to Swift.
//

#include <wchar.h>

int mk_wcwidth(wchar_t ucs);
int mk_wcswidth(const wchar_t *pwcs, size_t n);
int mk_wcwidth_cjk(wchar_t ucs);
int mk_wcswidth_cjk(const wchar_t *pwcs, size_t n);