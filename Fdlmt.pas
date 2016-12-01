unit Fdlmt;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, ExtCtrls;

const
     TmaxDLL   = 'tmaxmt.dll';
     MAXFBLEN        = $fffc;          { Maximum FBFR length }
{ =========== Field Key Buffer ============== }
     { field types }
     FB_CHAR        = 1;       { character }
     FB_SHORT       = 2;       { short int }
     FB_INT         = 3;       { short int }
     FB_LONG        = 4;       { long int }
     FB_FLOAT       = 5;       { single-precision float }
     FB_DOUBLE      = 6;       { double-precision float }
     FB_STRING      = 7;       { string - null terminated }
     FB_CARRAY      = 8;       { character array }

     { fb op mode }
     FBMOVEMD      = 1;
     FBCOPYMD      = 2;
     FBCOMPMD      = 3;
     FBCONCATMD    = 4;
     FBJOINMD      = 5;
     FBOJOINMD     = 6;
     FBUPDATEMD    = 7;

     { fberror code }
     FBEBADFB      = 3;
     FBEINVAL      = 4;
     FBELIMIT      = 5;
     FBENOENT      = 6;
     FBEOS         = 7;
     FBEBADFLD     = 8;
     FBEPROTO      = 9;
     FBENOSPACE    = 10;
     FBEMALLOC     = 11;
     FBESYSTEM     = 12;
     FBETYPE       = 13;
     FBEMATCH      = 14;
     FBEBADSTRUCT  = 15;
     FBEMAXNO      = 19;

     FSTDXINT        = 16;             { Default indexing interval }
     FMAXNULLSIZE    = 2660;
     FVIEWCACHESIZE  = 10;
     FVIEWNAMESIZE   = 33;

     BADFLDID = 0;
     FIRSTFLDID = 0;

type
    FdlMT_h = class(TComponent)
    public
        constructor Create(AOwner: TComponent); override;
    end;

    FIELDID  = Word;
    FLDLEN   = Word;
    FLDKEY   = word;
    NTH      = Integer;
    FLDOCC   = Integer;
    FPOS     = Integer; //수정
    pFIELDID = ^FIELDID;
    pFLDLEN  = ^FLDLEN;
    pFLDOCC  = ^FLDOCC;
    pFLDKEY  = ^FLDKEY;
    pNTH     = ^NTH;
    pPOS     = ^FPOS;  //수정

Function _Fget_Ferror_addr:Pointer; cdecl; far;
Function getfberrno:integer;  cdecl; far;

// field key buffer
Function fbput(a:Pointer; b:FLDKEY; c:Pointer; d:FLDLEN):Integer; cdecl; far;
Function fbget(a:Pointer; b:FLDKEY; c:Pointer; d:pFLDLEN):Integer; cdecl; far;
Function fbinsert(a:Pointer; b:FLDKEY; c:NTH; d:Pointer; e:FLDLEN):Integer; cdecl; far;
Function fbupdate(a:Pointer; b:FLDKEY; c:NTH; d:Pointer; e:FLDLEN):Integer; cdecl; far;
Function fbdelete(a:Pointer; b:FLDKEY; c:NTH):Integer; cdecl; far;
Function fbgetval(a:Pointer; b:FLDKEY; c:NTH; d:pFLDLEN):PChar; cdecl; far;
Function fbgetnth(a:Pointer; b:FLDKEY; c:Pointer; d:FLDLEN):Integer; cdecl; far;
Function fbkeyoccur(a:Pointer; b:FLDKEY):NTH; cdecl; far;
Function fbgetf(a:Pointer; b:FLDKEY; c:Pointer; d:pFLDLEN; e:pPOS):NTH; cdecl; far;

Function fbdelall(a:Pointer; b:FLDKEY):Integer; cdecl; far;
Function fbfldcount(a:Pointer):Integer; cdecl; far;
Function fbispres(a:Pointer; b:FLDKEY; c:NTH):Integer; cdecl; far;
Function fbgetvals(a:Pointer; b:FLDKEY; c:NTH):PChar; cdecl; far;
Function fbgetvali(a:Pointer; b:FLDKEY; c:NTH):Integer; cdecl; far;

Function fbtypecvt(a:pFLDLEN; b:Integer; c:Pointer; d:Integer; e:FLDLEN):PChar; cdecl; far;
Function fbputt(a:Pointer; b:FLDKEY; c:Pointer; d: FLDLEN; e:Integer):Integer; cdecl; far;
Function fbgetvalt(a:Pointer; b:FLDKEY; c:NTH; d:pFLDLEN; e:Integer):PChar; cdecl; far;
Function fbgetntht(a:Pointer; b:FLDKEY; c:Pointer; d:FLDLEN; e:Integer):Integer; cdecl; far;

Function fbget_fldkey(a:String):FLDKEY; cdecl; far;
Function fbget_fldname(a:FLDKEY):PChar; cdecl; far;
Function fbget_fldno(a:FLDKEY):Integer; cdecl; far;
Function fbget_fldtype(a:FLDKEY):Integer; cdecl; far;
Function fbget_strfldtype(a:FLDKEY):PChar; cdecl; far;
Function fbmake_fldkey(a:Integer; b:Integer):FLDKEY; cdecl; far;
Function fbnmkey_unload:Integer; cdecl; far;
Function fbkeynm_unload:Integer; cdecl; far;

Function fbisfbuf(a:Pointer):Integer; cdecl; far;
Function fbcalcsize(a:Integer; b:FLDLEN):Integer; cdecl; far;
Function fbinit(a:Pointer; b:FLDLEN):Integer; cdecl; far;
Function fballoc(a:Integer; b:Integer):Pointer; cdecl; far;
Function fbfree(a:Pointer):Integer; cdecl; far;
Function fbget_fbsize(a:Pointer):Integer; cdecl; far;
Function fbget_unused(a:Pointer):Integer; cdecl; far;
Function fbget_used(a:Pointer):Integer; cdecl; far;
Function fbrealloc(a:Pointer; b:Integer; c:Integer):Pointer; cdecl; far;

Function fbbufop(a:Pointer; b:Pointer; c:Integer):Integer; cdecl; far;
Function fbbufop_proj(a:Pointer; b:Integer; c:pFLDKEY):Integer; cdecl; far;

Function fbchg_tu(a:Pointer; b:FLDKEY; c:NTH; d:Pointer; e:FLDLEN):Integer; cdecl; far;
Function fbdelall_tu(a:Pointer; b:pFLDKEY):Integer; cdecl; far;
Function fbgetval_last_tu(a:Pointer; b:FLDKEY; c:pNTH; d:pFLDLEN):PChar; cdecl; far;
Function fbget_tu(a:Pointer; b:FLDKEY; c:NTH; d:Pointer; e:pPOS):Integer; cdecl; far;
Function fbgetalloc_tu(a:Pointer; b:FLDKEY; c:NTH; d:pPOS):PChar; cdecl; far;
Function fbgetlast_tu(a:Pointer; b:FLDKEY; c:pNTH; d:Pointer; e:pPOS):Integer; cdecl; far;
Function fbnext_tu(a:Pointer; b:pFLDKEY; c:pNTH; d:Pointer; e:pPOS):Integer; cdecl; far;
Function fbgetvals_tu(a:Pointer; b:FLDKEY; c:NTH):PChar; cdecl; far;
Function fbgetvall_tu(a:Pointer; b:FLDKEY; c:NTH):Integer; cdecl; far;
Function fbchg_tut(a:Pointer; b:FLDKEY; c:NTH; d:Pointer; e:FLDLEN; f:Integer):Integer; cdecl; far;
Function fbget_tut(a:Pointer; b:FLDKEY; c:NTH; d:Pointer; e:pFLDLEN; f:Integer):Integer; cdecl; far;
Function fbgetalloc_tut(a:Pointer; b:FLDKEY; c:NTH; d:Integer; e:Integer):PChar; cdecl; far;
Function fbgetlen(a:Pointer; b:FLDKEY; c:NTH):Integer; cdecl; far;

Function fbftos(a:Pointer; b:Pointer; c:Pointer):Integer; cdecl; far;
Function fbstof(a:Pointer; b:Pointer; c:Integer; d:Pointer):Integer; cdecl; far;
Function fbsnull(a:Pointer; b:Pointer; c:Integer; d:Pointer):Integer; cdecl; far;
Function fbstinit(a:Pointer; b:Pointer):Integer; cdecl; far;
Function fbstelinit(a:Pointer; b:Pointer; c:Pointer):Integer; cdecl; far;
Function fbstrerror(a:integer):Pointer; cdecl; far;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Tmax', [FdlMT_h]);
end;

constructor FdlMT_h.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

Function _Fget_Ferror_addr:Pointer; cdecl; external TmaxDLL;
Function getfberrno:integer;  cdecl; external TmaxDLL;

//field key buffer
Function fbput(a:Pointer; b:FLDKEY; c:Pointer; d:FLDLEN):Integer; cdecl; external TmaxDLL;
Function fbget(a:Pointer; b:FLDKEY; c:Pointer; d:pFLDLEN):Integer; cdecl; external TmaxDLL;
Function fbinsert(a:Pointer; b:FLDKEY; c:NTH; d:Pointer; e:FLDLEN):Integer; cdecl; external TmaxDLL;
Function fbupdate(a:Pointer; b:FLDKEY; c:NTH; d:Pointer; e:FLDLEN):Integer; cdecl; external TmaxDLL;
Function fbdelete(a:Pointer; b:FLDKEY; c:NTH):Integer; cdecl; external TmaxDLL;
Function fbgetval(a:Pointer; b:FLDKEY; c:NTH; d:pFLDLEN):PChar; cdecl; external TmaxDLL;
Function fbgetnth(a:Pointer; b:FLDKEY; c:Pointer; d:FLDLEN):Integer; cdecl; external TmaxDLL;
Function fbkeyoccur(a:Pointer; b:FLDKEY):NTH; cdecl; external TmaxDLL;
Function fbgetf(a:Pointer; b:FLDKEY; c:Pointer; d:pFLDLEN; e:pPOS):NTH; cdecl; external TmaxDLL;

Function fbdelall(a:Pointer; b:FLDKEY):Integer; cdecl; external TmaxDLL;
Function fbfldcount(a:Pointer):Integer; cdecl; external TmaxDLL;
Function fbispres(a:Pointer; b:FLDKEY; c:NTH):Integer; cdecl; external TmaxDLL;
Function fbgetvals(a:Pointer; b:FLDKEY; c:NTH):PChar; cdecl; external TmaxDLL;
Function fbgetvali(a:Pointer; b:FLDKEY; c:NTH):Integer; cdecl; external TmaxDLL;

Function fbtypecvt(a:pFLDLEN; b:Integer; c:Pointer; d:Integer; e:FLDLEN):PChar; cdecl; external TmaxDLL;
Function fbputt(a:Pointer; b:FLDKEY; c:Pointer; d: FLDLEN; e:Integer):Integer; cdecl; external TmaxDLL;
Function fbgetvalt(a:Pointer; b:FLDKEY; c:NTH; d:pFLDLEN; e:Integer):PChar; cdecl; external TmaxDLL;
Function fbgetntht(a:Pointer; b:FLDKEY; c:Pointer; d:FLDLEN; e:Integer):Integer; cdecl; external TmaxDLL;

Function fbget_fldkey(a:String):FLDKEY; cdecl; external TmaxDLL;
Function fbget_fldname(a:FLDKEY):PChar; cdecl; external TmaxDLL;
Function fbget_fldno(a:FLDKEY):Integer; cdecl; external TmaxDLL;
Function fbget_fldtype(a:FLDKEY):Integer; cdecl; external TmaxDLL;
Function fbget_strfldtype(a:FLDKEY):PChar; cdecl; external TmaxDLL;
Function fbmake_fldkey(a:Integer; b:Integer):FLDKEY; cdecl; external TmaxDLL;
Function fbnmkey_unload():Integer; cdecl; external TmaxDLL;
Function fbkeynm_unload():Integer; cdecl; external TmaxDLL;

Function fbisfbuf(a:Pointer):Integer; cdecl; external TmaxDLL;
Function fbcalcsize(a:Integer; b:FLDLEN):Integer; cdecl; external TmaxDLL;
Function fbinit(a:Pointer; b:FLDLEN):Integer; cdecl; external TmaxDLL;
Function fballoc(a:Integer; b:Integer):Pointer; cdecl; external TmaxDLL;
Function fbfree(a:Pointer):Integer; cdecl; external TmaxDLL;
Function fbget_fbsize(a:Pointer):Integer; cdecl; external TmaxDLL;
Function fbget_unused(a:Pointer):Integer; cdecl; external TmaxDLL;
Function fbget_used(a:Pointer):Integer; cdecl; external TmaxDLL;
Function fbrealloc(a:Pointer; b:Integer; c:Integer):Pointer; cdecl; external TmaxDLL;

Function fbbufop(a:Pointer; b:Pointer; c:Integer):Integer; cdecl; external TmaxDLL;
Function fbbufop_proj(a:Pointer; b:Integer; c:pFLDKEY):Integer; cdecl; external TmaxDLL;

Function fbchg_tu(a:Pointer; b:FLDKEY; c:NTH; d:Pointer; e:FLDLEN):Integer; cdecl; external TmaxDLL;
Function fbdelall_tu(a:Pointer; b:pFLDKEY):Integer; cdecl; external TmaxDLL;
Function fbgetval_last_tu(a:Pointer; b:FLDKEY; c:pNTH; d:pFLDLEN):PChar; cdecl; external TmaxDLL;
Function fbget_tu(a:Pointer; b:FLDKEY; c:NTH; d:Pointer; e:pPOS):Integer; cdecl; external TmaxDLL;
Function fbgetalloc_tu(a:Pointer; b:FLDKEY; c:NTH; d:pPOS):PChar; cdecl; external TmaxDLL;
Function fbgetlast_tu(a:Pointer; b:FLDKEY; c:pNTH; d:Pointer; e:pPOS):Integer; cdecl; external TmaxDLL;
Function fbnext_tu(a:Pointer; b:pFLDKEY; c:pNTH; d:Pointer; e:pPOS):Integer; cdecl; external TmaxDLL;
Function fbgetvals_tu(a:Pointer; b:FLDKEY; c:NTH):PChar; cdecl; external TmaxDLL;
Function fbgetvall_tu(a:Pointer; b:FLDKEY; c:NTH):Integer; cdecl; external TmaxDLL;
Function fbchg_tut(a:Pointer; b:FLDKEY; c:NTH; d:Pointer; e:FLDLEN; f:Integer):Integer; cdecl; external TmaxDLL;
Function fbget_tut(a:Pointer; b:FLDKEY; c:NTH; d:Pointer; e:pFLDLEN; f:Integer):Integer; cdecl; external TmaxDLL;
Function fbgetalloc_tut(a:Pointer; b:FLDKEY; c:NTH; d:Integer; e:Integer):PChar; cdecl; external TmaxDLL;
Function fbgetlen(a:Pointer; b:FLDKEY; c:NTH):Integer; cdecl; external TmaxDLL;

Function fbftos(a:Pointer; b:Pointer; c:Pointer):Integer; cdecl; external TmaxDLL;
Function fbstof(a:Pointer; b:Pointer; c:Integer; d:Pointer):Integer; cdecl; external TmaxDLL;
Function fbsnull(a:Pointer; b:Pointer; c:Integer; d:Pointer):Integer; cdecl; external TmaxDLL;
Function fbstinit(a:Pointer; b:Pointer):Integer; cdecl; external TmaxDLL;
Function fbstelinit(a:Pointer; b:Pointer; c:Pointer):Integer; cdecl; external TmaxDLL;
Function fbstrerror(a:integer):Pointer; cdecl; external TmaxDLL;

end.

