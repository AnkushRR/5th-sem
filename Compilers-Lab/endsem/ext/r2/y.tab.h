#define INTEGER 257
#define FLOAT 258
#define LETTER 259
#define TT 260
#define TYPE 261
#define KK 262
#define LL 263
#define YY 264
#define JJ 265
#ifdef YYSTYPE
#undef  YYSTYPE_IS_DECLARED
#define YYSTYPE_IS_DECLARED 1
#endif
#ifndef YYSTYPE_IS_DECLARED
#define YYSTYPE_IS_DECLARED 1
typedef union { struct node *a; 
         } YYSTYPE;
#endif /* !YYSTYPE_IS_DECLARED */
extern YYSTYPE yylval;
