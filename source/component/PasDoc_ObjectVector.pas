{
  @cvs($Date$)
  @author(Johannes Berg <johannes@sipsolutions.de>)
  @author(Michalis Kamburelis)
  a simple object vector
}
unit PasDoc_ObjectVector;

interface
uses
  Contnrs,
  Classes;

type
  TObjectVector = class(TObjectList)
  public
    { This is only to make constructor virtual, while original
      TObjectList has a static constructor. }
    constructor Create(const AOwnsObject: boolean); virtual;
{$IFDEF fpc}
{$ELSE}
  //fix bug in D7 TList.Sort
    procedure Sort(Compare: TListSortCompare); reintroduce;
{$ENDIF}
  end;

function ObjectVectorIsNilOrEmpty(const AOV: TObjectVector): boolean; 

implementation

function ObjectVectorIsNilOrEmpty(const AOV: TObjectVector): boolean;
begin
  Result := not Assigned(AOV);
  if not Result then begin
    Result := AOV.Count = 0;
  end;
end;

{ TObjectVector }

constructor TObjectVector.Create(const AOwnsObject: boolean);
begin
  inherited Create(AOwnsObject);
end;

{$IFDEF fpc}
{$ELSE}
procedure TObjectVector.Sort(Compare: TListSortCompare);
begin
  if Count <= 1 then
    exit;
  inherited;
end;
{$ENDIF}

end.
