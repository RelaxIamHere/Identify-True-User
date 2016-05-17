var editor;

function init(postBack) {
    editor = CodeMirror.fromTextArea(
                document.getElementById('MainContent_TextBoxCode'),
                    {
                        lineNumbers: true,
                        matchBrackets: true,
                        theme: "ambiance"
                    }
                );
    editor.setSize("", 410);
    editor.display.wrapper.style.fontSize = "12px";
    setMode();
    if (postBack == 0)
        fillSampleCode();

 
}


function fillSampleCode() {
    var languages = document.getElementById("MainContent_DropDownLanguage");
    var language = languages[languages.selectedIndex].text;
    setMode();
    if (language == "Ada (gnat 5.1.1)") {
        editor.getDoc().setValue(
'With Ada.Text_IO; Use Ada.Text_IO;\n\
With Ada.Integer_Text_IO; Use Ada.Integer_Text_IO;\n\
\n\
procedure Program is\n\
begin\n\
  -- your code goes here\n\
end Program;'
        );
    }
    else if (language == "Assembler (gcc 4.9.3)") {
        editor.getDoc().setValue(
'.data\n\
\n\
.text\n\
\n\
.global main\n\
main:    				# int main()\n\
						# {\n\
\n\
	# your code goes here\n\
\n\
	xor	%eax, %eax		# return 0;\n\
	ret\n\
						# }'
        );
    }
    else if (language == "Assembler (NASM 2.11.05)") {
        editor.getDoc().setValue(
'global _start\n\
\n\
section .data\n\
\n\
section .text\n\
\n\
_start:\n\
	; your code goes here\n\
	je		exit\n\
\n\
exit:\n\
	mov		eax, 01h		; exit()\n\
	xor		ebx, ebx		; errno\n\
	int		80h'
        );
    }
    else if (language == "AWK (gawk) (fawk 4.1.1)") {
        editor.getDoc().setValue(
'BEGIN {\n\
	// your code goes here\n\
}\n\
\n\
{\n\
	// your code goes here\n\
}\n\
\n\
END {\n\
	// your code goes here\n\
}'
        );
    }
    else if (language == "Bash (bash 4.3.33)") {
        editor.getDoc().setValue(
'#!/bin/bash\n\
# your code goes here'
        );
    }
    else if (language == "bc (bc 1.06.95)") {
        editor.getDoc().setValue(
'/* write your code below */'
        );
    }
    else if (language == "Brainf**k (1.0.6)") {
        editor.getDoc().setValue(
'/* write your code below */'
        );
    }
    else if (language == "C (gcc 5.1.1)") {
    editor.getDoc().setValue(
'#include<stdio.h>\n\
\n\
int main() {\n\
    int n;\n\
	while(scanf("%d\", &n) != -1)\n\
	{\n\
		int i;\n\
	    long long sum = 0;\n\
	    for (i=1; i <= n; i++)\n\
	    {\n\
		    sum += i*i;\n\
		    printf("%lld\ ", sum);\n\
	    }\n\
	}\n\
	return 0;\n\
}'
        );
    }
    else if (language == "C# (Mono 4.0.2)") {
        editor.getDoc().setValue(
'using System;\n\
\n\
public class Test\n\
{\n\
	public static void Main()\n\
	{\n\
		// your code goes here\n\
	}\n\
}'
        );
    }
    else if (language == "C++ (5.1.1)") {
        editor.getDoc().setValue(
'#include <iostream>\n\
using namespace std;\n\
\n\
int main() {\n\
	// your code goes here\n\
	return 0;\n\
}'
        );
    }
    else if (language == "C++ 4.3.2 (gcc-4.3.2)") {
        editor.getDoc().setValue(
'#include <iostream>\n\
using namespace std;\n\
\n\
int main() {\n\
	// your code goes here\n\
	return 0;\n\
}'
        );
    }
    else if (language == "C++14 (gcc-5 5.1.1)") {
        editor.getDoc().setValue(
'#include <iostream>\n\
using namespace std;\n\
\n\
int main() {\n\
	// your code goes here\n\
	return 0;\n\
}'
        );
    }
    else if (language == "C99 strict (gcc-5 5.1.1)") {
        editor.getDoc().setValue(
'#include <stdio.h>\n\
\n\
int main(void) {\n\
	// your code goes here\n\
	return 0;\n\
}'
        );
    }
    else if (language == "CLIPS (clips 6.24)") {
        editor.getDoc().setValue(
'; your code goes here\n\
\n\
(exit)\n\
; empty line at the end'
        );
    }
    else if (language == "Clojure (clojure 1.7.0)") {
        editor.getDoc().setValue(
'; your code goes here'
        );
    }
    else if (language == "COBOL (1.1.0)") {
        editor.getDoc().setValue(
'	IDENTIFICATION DIVISION.\n\
	PROGRAM-ID. IDEONE.\n\
\n\
	ENVIRONMENT DIVISION.\n\
\n\
	DATA DIVISION.\n\
\n\
	PROCEDURE DIVISION.\n\
	*>	your code goes here\n\
		STOP RUN.'
        );
    }
    else if (language == "Common Lisp (clisp) (clisk 2.49)") {
        editor.getDoc().setValue(
'; your code goes here'
        );
    }
    else if (language == "D (gdc-5 5.1.1)") {
        editor.getDoc().setValue(
'import std.c.stdio;\n\
\n\
int main() {\n\
	// your code goes here\n\
	return 0;\n\
}'
        );
    }
    else if (language == "Erlang (erl 18)") {
        editor.getDoc().setValue(
'-module(prog).\n\
-export([main/0]).\n\
\n\
main() ->\n\
	% your code goes here\n\
	true.'
        );
    }
    else if (language == "F# (1.3)") {
        editor.getDoc().setValue(
'open System\n\
\n\
// your code goes here'
        );
    }
    else if (language == "Forth (gforth 0.7.2)") {
        editor.getDoc().setValue(
'( your code goes here )'
        );
    }
    else if (language == "Fortran (5.1.1)") {
        editor.getDoc().setValue(
'program TEST\n\
	! your code goes here\n\
	stop\n\
end'
        );
    }
    else if (language == "Go (1.4)") {
        editor.getDoc().setValue(
'package main\n\
import "fmt"\n\
\n\
func main(){\n\
	// your code goes here\n\
}'
        );
    }
    else if (language == "Groovy (2.4)") {
        editor.getDoc().setValue(
'// your code goes here'
        );
    }
    else if (language == "Haskell (ghc 7.8)") {
        editor.getDoc().setValue(
'main = -- your code goes here'
        );
    }
    else if (language == "Icon (icon 9.4.3)") {
        editor.getDoc().setValue(
'procedure main()\n\
	# your code goes here\n\
end'
        );
    }
    else if (language == "Intercal (c-intercal 28.0-r1)") {
        editor.getDoc().setValue(
''
        );
    }
    else if (language == "Java (jdk 8u51)") {
        editor.getDoc().setValue(
'/* package whatever; // don\'t place package name! */\n\
\n\
import java.util.*;\n\
import java.lang.*;\n\
import java.io.*;\n\
\n\
/* Name of the class has to be "Main" only if the class is public. */\n\
class Ideone\n\
{\n\
	public static void main (String[] args) throws java.lang.Exception\n\
	{\n\
		// your code goes here\n\
	}\n\
}'
        );
    }
    else if (language == "JavaScript (rhino) (rhino 1.7.7)") {
        editor.getDoc().setValue(
'importPackage(java.io);\n\
importPackage(java.lang);\n\
\n\
// your code goes here'
        );
    }
    else if (language == "JavaScript (spidermonkey) (24.2.0)") {
        editor.getDoc().setValue(
'// your code goes here'
        );
    }
    else if (language == "Lua (lua 7.2)") {
        editor.getDoc().setValue(
'-- your code goes here'
        );
    }
    else if (language == "Nice (0.9.13)") {
        editor.getDoc().setValue(
'void main (String[] args)\n\
{\n\
	// your code goes here\n\
}'
        );
    }
    else if (language == "Node.js (v0.12.7)") {
        editor.getDoc().setValue(
'process.stdin.resume();\n\
process.stdin.setEncoding(\'utf8\');\n\
\n\
// your code goes here'
        );
    }
    else if (language == "Objective-C (gcc-5 5.1.1)") {
        editor.getDoc().setValue(
'#import <objc/objc.h>\n\
#import <objc/Object.h>\n\
#import <Foundation/Foundation.h>\n\
\n\
@implementation TestObj\n\
int main()\n\
{\n\
	// your code goes here\n\
	return 0;\n\
}\n\
@end'
        );
    }
    else if (language == "Ocaml (4.01.0)") {
        editor.getDoc().setValue(
'(* your code goes here *)'
        );
    }
    else if (language == "Octave (4.0.0)") {
        editor.getDoc().setValue(
'# your code goes here'
        );
    }
    else if (language == "Pascal (fpc) (fpc 2.6.4+dfsg-6)") {
        editor.getDoc().setValue(
'program ideone;\n\
begin\n\
	(* your code goes here *)\n\
end.'
        );
    }
    else if (language == "Pascal (gpc) (gpc 20070904)") {
        editor.getDoc().setValue(
'program ideone;\n\
begin\n\
	(* your code goes here *)\n\
end.'
        );
    }
    else if (language == "Perl (perl 5.20.1)") {
        editor.getDoc().setValue(
'#!/usr/bin/perl\n\
# your code goes here'
        );
    }
    else if (language == "Perl 6 (perl6 2014.07)") {
        editor.getDoc().setValue(
'#!/usr/bin/perl\n\
# your code goes here'
        );
    }
    else if (language == "PHP (PHP 5.6.11-1)") {
        editor.getDoc().setValue(
'<?php\n\
\n\
// your code goes here'
        );
    }
    else if (language == "Pike (pike v7.8)") {
        editor.getDoc().setValue(
'int main() {\n\
	// your code goes here\n\
}'
        );
    }
    else if (language == "Prolog (swi) (swi 7.2)") {
        editor.getDoc().setValue(
':- set_prolog_flag(verbose,silent).\n\
:- prompt(_, \'\').\n\
:- use_module(library(readutil)).\n\
\n\
main:-\n\
	process,\n\
	halt.\n\
\n\
process:-\n\
	/* your code goes here */\n\
	true.\n\
\n\
:- main.'
        );
    }
    else if (language == "Python (2.7.10)") {
        editor.getDoc().setValue(
'# your code goes here'
        );
    }
    else if (language == "Python (Pypy) (PyPy 2.6.0)") {
        editor.getDoc().setValue(
'# your code goes here'
        );
    }
    else if (language == "Python 3 (Python 3.4.3+)") {
        editor.getDoc().setValue(
'# your code goes here'
        );
    }
    else if (language == "R (3.2.2)") {
        editor.getDoc().setValue(
'# your code goes here'
        );
    }
    else if (language == "Ruby (ruby 2.1.5)") {
        editor.getDoc().setValue(
'# your code goes here'
        );
    }
    else if (language == "Scala (2.11.7)") {
        editor.getDoc().setValue(
'object Main extends App {\n\
	// your code goes here\n\
}'
        );
    }
    else if (language == "Scheme (guile) (guile 2.0.11)") {
        editor.getDoc().setValue(
'; your code goes here'
        );
    }
    else if (language == "Sed (sed 4.2.2)") {
        editor.getDoc().setValue(
'"your code goes here"'
        );
    }
    else if (language == "Smalltalk (gst 3.2.4)") {
        editor.getDoc().setValue(
'"your code goes here"'
        );
    }
    else if (language == "SQL (sqlite3-3.8.7)") {
        editor.getDoc().setValue(
'-- your code goes here'
        );
    }
    else if (language == "Tcl (tclsh 8.6)") {
        editor.getDoc().setValue(
';# your code goes here'
        );
    }
    else if (language == "Whitespace (wspace 0.3)") {
        editor.getDoc().setValue(
''
        );
    }
    else
        editor.getDoc().setValue('');
    
    editor.focus();
}


function setMode() {
    var languages = document.getElementById("MainContent_DropDownLanguage");
    var language = languages[languages.selectedIndex].text;

    if (language == "Ada (gnat 5.1.1)") {
      
    }
    else if (language == "Assembler (gcc 4.9.3)") {
     
    }
    else if (language == "Assembler (NASM 2.11.05)") {
      
    }
    else if (language == "AWK (gawk) (fawk 4.1.1)") {
     
    }
    else if (language == "Bash (bash 4.3.33)") {
    
    }
    else if (language == "bc (bc 1.06.95)") {
      
    }
    else if (language == "Brainf**k (1.0.6)") {

    }
    else if (language == "C (gcc 5.1.1)") {
        editor.setOption("mode", "text/x-csrc");
    }
    else if (language == "C# (Mono 4.0.2)") {
        editor.setOption("mode", "text/x-csharp");
    }
    else if (language == "C++ (5.1.1)") {
        editor.setOption("mode", "text/x-c++src");
    }
    else if (language == "C++ 4.3.2 (gcc-4.3.2)") {
        editor.setOption("mode", "text/x-c++src");
    }
    else if (language == "C++14 (gcc-5 5.1.1)") {
        editor.setOption("mode", "text/x-c++src");
    }
    else if (language == "C99 strict (gcc-5 5.1.1)") {
        editor.setOption("mode", "text/x-csrc");
    }
    else if (language == "CLIPS (clips 6.24)") {
    }
    else if (language == "Clojure (clojure 1.7.0)") {
    }
    else if (language == "COBOL (1.1.0)") {

    }
    else if (language == "Common Lisp (clisp) (clisk 2.49)") {

    }
    else if (language == "D (gdc-5 5.1.1)") {

    }
    else if (language == "Erlang (erl 18)") {

    }
    else if (language == "F# (1.3)") {

    }
    else if (language == "Forth (gforth 0.7.2)") {

    }
    else if (language == "Fortran (5.1.1)") {

    }
    else if (language == "Go (1.4)") {

    }
    else if (language == "Groovy (2.4)") {

    }
    else if (language == "Haskell (ghc 7.8)") {

    }
    else if (language == "Icon (icon 9.4.3)") {

    }
    else if (language == "Intercal (c-intercal 28.0-r1)") {

    }
    else if (language == "Java (jdk 8u51)") {
        editor.setOption("mode", "text/x-java");
    }
    else if (language == "JavaScript (rhino) (rhino 1.7.7)") {

    }
    else if (language == "JavaScript (spidermonkey) (24.2.0)") {

    }
    else if (language == "Lua (lua 7.2)") {

    }
    else if (language == "Nice (0.9.13)") {

    }
    else if (language == "Node.js (v0.12.7)") {

    }
    else if (language == "Objective-C (gcc-5 5.1.1)") {
        editor.setOption("mode", "text/x-objectivec");
    }
    else if (language == "Ocaml (4.01.0)") {

    }
    else if (language == "Octave (4.0.0)") {

    }
    else if (language == "Pascal (fpc) (fpc 2.6.4+dfsg-6)") {

    }
    else if (language == "Pascal (gpc) (gpc 20070904)") {

    }
    else if (language == "Perl (perl 5.20.1)") {

    }
    else if (language == "Perl 6 (perl6 2014.07)") {

    }
    else if (language == "PHP (PHP 5.6.11-1)") {

    }
    else if (language == "Pike (pike v7.8)") {

    }
    else if (language == "Prolog (swi) (swi 7.2)") {

    }
    else if (language == "Python (2.7.10)") {

    }
    else if (language == "Python (Pypy) (PyPy 2.6.0)") {

    }
    else if (language == "Python 3 (Python 3.4.3+)") {

    }
    else if (language == "R (3.2.2)") {

    }
    else if (language == "Ruby (ruby 2.1.5)") {

    }
    else if (language == "Scala (2.11.7)") {
        editor.setOption("mode", "text/x-scala");
    }
    else if (language == "Scheme (guile) (guile 2.0.11)") {

    }
    else if (language == "Sed (sed 4.2.2)") {

    }
    else if (language == "Smalltalk (gst 3.2.4)") {

    }
    else if (language == "SQL (sqlite3-3.8.7)") {

    }
    else if (language == "Tcl (tclsh 8.6)") {

    }
    else if (language == "Whitespace (wspace 0.3)") {

    }  
}