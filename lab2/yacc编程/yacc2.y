%{
/*********************************************
中缀表达式转后缀表达式
**********************************************/
#include<stdio.h>
#include<stdlib.h>
#include<ctype.h>
#include<string.h>
#ifndef YYSTYPE
#define YYSTYPE char*      
#endif
int yylex();
extern int yyparse();
FILE* yyin;
void yyerror(const char* s);
char id[100];     //标识符
char num[100];
%}

//TODO:给每个符号定义一个单词类别
%token ADD MINUS
%token MUL DIV
%token LEFTPAR RIGHTPAR
%token NUMBER
%token ID     //标识符


%left ADD MINUS
%left MUL DIV
%right UMINUS         
%left LEFTPAR RIGHTPAR
%%


lines   :       lines expr ';' { printf("%s\n", $2); }
        |       lines ';'
        |
        ;
//TODO:完善表达式的规则
expr    :       expr ADD expr   { $$=(char*)malloc(100*sizeof(char)); strcpy($$,$1); strcat($$,$3); strcat($$,"+ "); }
        |       expr MINUS expr   {  $$=(char*)malloc(100*sizeof(char)); strcpy($$,$1); strcat($$,$3); strcat($$,"- "); }
        |       expr MUL expr   { $$=(char*)malloc(100*sizeof(char)); strcpy($$,$1); strcat($$,$3); strcat($$,"* "); }
        |       expr DIV expr   { $$=(char*)malloc(100*sizeof(char)); strcpy($$,$1); strcat($$,$3); strcat($$,"/ "); } 
        |       LEFTPAR expr RIGHTPAR { $$=(char *)malloc(100*sizeof(char)); strcpy($$,$2); }
        |       MINUS expr %prec UMINUS   {$$ = (char*)malloc(100*sizeof(char)); strcpy($$,"- "); strcat($$,$2); }
        |       NUMBER  {$$=(char *)malloc(100*sizeof(char)); strcpy($$,$1); strcat($$," ");}
        |       ID  {$$=(char *)malloc(100*sizeof(char)); strcpy($$,$1); strcat($$," ");}
        ;

%%

// programs section

int yylex()
{
    int t;
    while(1){
        t=getchar();
        if(t==' '||t=='\t'||t=='\n'){
            //do noting
        }else if(isdigit(t)){
            //TODO:解析多位数字返回数字类型 
            int i=0;
            while(isdigit(t))
            {
                num[i] = t;
                t=getchar();
                i++;
            }
            num[i]='\0';        //当前字符串结束
            yylval=num;       
            ungetc(t,stdin);     
            return NUMBER;
        }
      //识别大小写字母及下划线
       else if((t>='A'&&t<='Z')||(t>='a'&&t<='z')||(t=='_'))
       {
            int i=0;
            while((isdigit(t))||(t>='A'&&t<='Z')||(t>='a'&&t<='z')||(t=='_'))
            {
                id[i]=t;
                i++;
                t=getchar();
            }
            id[i]='\0';
            yylval=id;
            ungetc(t,stdin);
            return ID; 
        }else if(t=='+'){
            return ADD;
        }else if(t=='-'){
            return MINUS;
        }else if(t=='*'){
            return MUL;
        }else if(t=='/'){
            return DIV;
        }else if(t=='('){
            return LEFTPAR;
        }else if(t==')'){
            return RIGHTPAR;
        }
        else{
            return t;
        }
    }
}

int main(void)
{
    yyin=stdin;
    do{
        yyparse();
    }while(!feof(yyin));
    return 0;
}
void yyerror(const char* s){
    fprintf(stderr,"Parse error: %s\n",s);
    exit(1);
}
