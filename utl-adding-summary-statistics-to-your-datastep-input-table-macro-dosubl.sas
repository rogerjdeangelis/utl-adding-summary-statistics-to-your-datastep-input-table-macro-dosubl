%let pgm=utl-adding-summary-statistics-to-your-datastep-input-table-macro-dosubl;

adding-summary-statistics-to-your-datastep-input-table-macro-dosubl;

Problem
   Add geometric standard deviation(or any summary statistic) to input table

Macros on end

github
https://tinyurl.com/4hnjnjkr
https://github.com/rogerjdeangelis/utl-adding-summary-statistics-to-your-datastep-input-table-macro-dosubl

/*                   _
(_)_ __  _ __  _   _| |_
| | `_ \| `_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
*/

libname sd1 "d:/sd1";
data sd1.Have;
call streaminit(12345);
do i = 1 to 10;
   x = round( rand("LogNormal", 3, 0.8), 0.1);
   output;
end;
run;

/**************************************************************************************************************************/
/*                         |                                         |                                                    */
/*  INPUT                  |    PROCESS                              |  SD1.WANTWANT                                      */
/*                         |                                         |                                                    */
/*  SD1.HAVE total obs=10  |    data want;                           |                   added geometric stdev            */
/*                         |      set sd1.have %geostd(sd1.have,x);  |   Obs     I      X      GEOSTD                     */
/*  Obs     I      X       |    run;quit;                            |                                                    */
/*                         |                                         |     1     1    24.8    2.02672                     */
/*    1     1    24.8      |                                         |     2     2    47.5    2.02672                     */
/*    2     2    47.5      |                                         |     3     3    38.6    2.02672                     */
/*    3     3    38.6      |                                         |     4     4    12.9    2.02672                     */
/*    4     4    12.9      |                                         |     5     5    68.9    2.02672                     */
/*    5     5    68.9      |                                         |     6     6     7.5    2.02672                     */
/*    6     6     7.5      |                                         |     7     7    17.9    2.02672                     */
/*    7     7    17.9      |                                         |     8     8    46.2    2.02672                     */
/*    8     8    46.2      |                                         |     9     9    21.2    2.02672                     */
/*    9     9    21.2      |                                         |    10    10    53.5    2.02672                     */
/*   10    10    53.5      |                                         |                                                    */
/*                                                                                                                        */
/**************************************************************************************************************************/


/*
 _ __  _ __ ___   ___ ___  ___ ___
| `_ \| `__/ _ \ / __/ _ \/ __/ __|
| |_) | | | (_) | (_|  __/\__ \__ \
| .__/|_|  \___/ \___\___||___/___/
|_|
*/

/* Probably no needed. Clean up all the sasmac1-         ----*/
%deleteSasMacN;
%symdel dsn var / nowarn;

data want;
  set sd1.have %geostd(sd1.have,x);
run;quit;

/*           _               _
  ___  _   _| |_ _ __  _   _| |_
 / _ \| | | | __| `_ \| | | | __|
| (_) | |_| | |_| |_) | |_| | |_
 \___/ \__,_|\__| .__/ \__,_|\__|
                |_|
*/

 /**************************************************************************************************************************/
 /*                                                                                                                        */
 /*  Obs     I      X      GEOSTD                                                                                          */
 /*                                                                                                                        */
 /*    1     1    24.8    2.02672                                                                                          */
 /*    2     2    47.5    2.02672                                                                                          */
 /*    3     3    38.6    2.02672                                                                                          */
 /*    4     4    12.9    2.02672                                                                                          */
 /*    5     5    68.9    2.02672                                                                                          */
 /*    6     6     7.5    2.02672                                                                                          */
 /*    7     7    17.9    2.02672                                                                                          */
 /*    8     8    46.2    2.02672                                                                                          */
 /*    9     9    21.2    2.02672                                                                                          */
 /*   10    10    53.5    2.02672                                                                                          */
 /*                                                                                                                        */
 /**************************************************************************************************************************/

/*
 _ __ ___   __ _  ___ _ __ ___  ___
| `_ ` _ \ / _` |/ __| `__/ _ \/ __|
| | | | | | (_| | (__| | | (_) \__ \
|_| |_| |_|\__,_|\___|_|  \___/|___/

*/


%macro geostd(dsn,var);

   %dosubl('
      %*let dsn=sd1.have;
      %*let var=x;
      proc sql;
        create
           table &dsn as
        select
          l.*
          ,exp(r.logw) as geostd
        from
          &dsn as l
          left join (select std(log(&var)) as logw from &dsn) as r
        on
          1=1
      ;quit;
    ');

%mend geostd;

%macro deleteSasmacN()
   /des="Delete all numberes sasmacr# libraries. does not delete sasnacr";

   proc sql;
     select
        memname
     into
        :_catNam separated by " "
     from
        sashelp.vscatlg
     where
            libname =   "WORK"
        and memname eqt "SASMAC"
        and memname ne  "SASMACR"
   ;quit;

   %put &=sqlobs;

   %if &sqlobs %then %do;
      proc datasets lib=work mt=cat ;
         delete &_catNam;
      run;quit;
   %end;

%mend deleteSasmacN;

%deleteSasMacN;

/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/


























/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/


















%macro geostd(dsn,var);

   %dosubl('
      %*let dsn=sd1.have;
      %*let var=x;
      proc sql;
        create
           table &dsn as
        select
          l.*
          ,exp(r.logw) as geostd
        from
          &dsn as l
          left join (select std(log(&var)) as logw from &dsn) as r
        on
          1=1
      ;quit;
    ');

%mend geostd;

data want;
  set sd1.have %geostd(sd1.have,x);
run;quit;


SYMBOLGEN:  Macro variable ARG resolves to "                  proc sql;        create           table sd1.have as        select          l.*          ,exp(r.logw) as
            geostd        from          sd1.have as l          left join (select std(log(geostd)) as logw from sd1.have) as r        on          1=1      ;quit;








               ;;;;%end;%mend;/*'*/ *);*};*];*/;/*"*/;run;quit;%end;end;run;endcomp;%utlfix;











 proc sql;
  update sd1.have;
  set

proc sql;
    table sd1.have
    add geostd date;
    update  sd1.have
    set geostd =(
        select
           exp(r.logw) as geostd
        from
          sd1.have as l
          left join (select std(log(&arg)) as logw from sd1.have) as r
        on
          1=1);
quit;


proc sql;
    alter table sd1.have
    add geostd date;
    update  sd1.have
    set geostd =(
        select
           exp(r.logw) as geostd
        from
          sd1.have as l
          left join (select std(log(x)) as logw from sd1.have) as r
        on
          1=1);
quit;



















      data sd1.have;
         set sd1.have;
         geostd=99;
      run;quit;
   ');
  end;

  set sd1.have;

run;quit;

















/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/


libname sd1 "d:/sd1";
options cmplib=work.functions;
proc fcmp outlib=work.functions.temp;
Subroutine roundup(x, y, base);
    outargs y;
    y = ceil(x/base)*base;
endsub;
run;quit;

data sd1.want ;
    set sd1.have;
    call roundup(x,y,3);
    put y;
run;quit;

proc print;
run;quit;


options cmplib=work.functions;
proc fcmp outlib=work.functions.geostats;
function geoc(var);
    outargs ;

    filename clp clipbrd; /*---- SURPRISED                     ----*/

    length ttl $2550; /*---- SAS MAX SIZE FOR 10 TITLES        ----*/

    /*---- RESET TO DEFAULT CLIPBRD TEXT                       ----*/
    %DOSUBL('
       data _null_;
          file clp;
          put "default";
       run;quit;
    ');

    %dosubl('
     select std(log(x)) as logw from sd1.have
     length ttl $2550;
     file clp;
     do until (dne);
        set work.title end=dne;
        ttl=catx('|',ttl,text);
     end;
     put ttl;
     stop;
     run;quit;
   ');

   %dosubl('
     data _null_ ;
       length ttl $2550;
       infile clp;
       input;
       put _infile_;
       call symputx("ttl",_infile_);
     run;quit;
   ');

    ttl = "&ttl";

return(ttl);

endfunc;
run;quit;

data _null_;
  length title $2550;
  title=mytitle(title);
  put title=;
run;quit;

%put 'Macro System Function   : %sysfunc(mytitle(title)) is' %sysfunc(mytitle(title));
