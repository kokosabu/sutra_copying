% 3 宣言的プログラミング技法

% 3.1 宣言的とはどういうことか?

% 3.1.1 宣言的プログラムの分類

% 3.1.2 仕様記述言語

% 3.1.3 宣言的モデルにおいてコンポーネントを実装すること
% if X>Y then Z=X else Z=Y end

% 3.2 反復計算

% 3.2.1 一般的図式
% fun {Iterate S_i}
%    if {IsDone S_i} then S_i
%    else S_i+1 in
%       S_i+1={Transform S_i}
%       {Iterate S_i+1}
%    end
% end

% 3.2.2 数についての反復
declare
fun {Sqrt X}
   Guess=1.0
in
   {SqrtIter Guess X}
end
fun {SqrtIter Guess X}
   if {GoodEnough Guess X} then Guess
   else
      {SqrtIter {Improve Guess X} X}
   end
end
fun {Improve Guess X}
   (Guess + X/Guess) / 2.0
end
fun {GoodEnough Guess X}
   {Abs X-Guess*Guess}/X < 0.00001
end
fun {Abs X} if X < 0.0 then ~X else X end end

% 3.2.3 局所的手続きを使うこと
local
   fun {SqrtIter Guess X}
      if {GoodEnough Guess X} then Guess
      else
	 {SqrtIter {Improve Guess X} X}
      end
   end
   fun {Improve Guess X}
      (Guess + X/Guess) / 2.0
   end
   fun {GoodEnough Guess X}
      {Abs X-Guess*Guess}/X < 0.00001
   end
in
   fun {Sqrt X}
      Guess=1.0
   in
      {SqrtIter Guess X}
   end
end


fun {Sqrt X}
   fun {SqrtIter Guess X}
      fun {Improve Guess X}
	 (Guess + X/Guess) / 2.0
      end
      fun {GoodEnough Guess X}
	 {Abs X-Guess*Guess}/X < 0.00001
      end
   in
      if {GoodEnough Guess X} then Guess
      else
	 {SqrtIter {Improve Guess X} X}
      end
   end
   Guess=1.0
in
   {SqrtIter Guess X}
end


fun {Sqrt X}
   fun {SqrtIter Guess}
      fun {Improve}
	 (Guess + X/Guess) / 2.0
      end
      fun {GoodEnough}
	 {Abs X-Guess*Guess}/X < 0.00001
      end
   in
      if {GoodEnough} then Guess
      else
	 {SqrtIter {Improve}}
      end
   end
   Guess=1.0
in
   {SqrtIter Guess}
end


fun {Sqrt X}
   fun {Improve Guess}
      (Guess + X/Guess) / 2.0
   end
   fun {GoodEnough Guess}
      {Abs X-Guess*Guess}/X < 0.00001
   end
   fun {SqrtIter Guess}
      if {GoodEnough Guess} then Guess
      else
	 {SqrtIter {Improve Guess}}
      end
   end
   Guess=1.0
in
   {SqrtIter Guess}
end

% 3.2.4 一般図式から制御抽象へ
% fun {Iterate S_i}
%    if { IsDone S_i } then S_i
%    else S_i+1 in
%       S_i+1={ Transform S_i }
%       {Iterate S_i+1}
%    end
% end
declare
fun {Iterate S IsDone Transform}
   if {IsDone S} then S
   else S1 in
      S1={Transform S}
      {Iterate S1 IsDone Transform}
   end
end

fun {Sqrt X}
   {Iterate
    1.0
    fun {$ G} {Abs X-G*G}\X < 0.00001 end
    fun {$ G} (G+X/G)/2.0 end}
end

% 3.3 再帰計算

declare
fun {Fact N}
   if N==0 then 1
   elseif N>0 then N*{Fact N-1}
   else raise domainError end
   end
end

% 3.3.1 スタックの大きさの増加

declare
proc {Fact N ?R}
   if N==0 then R=1
   elseif N>0 then N1 R1 in
      N1=N-1
      {Fact N1 R1}
      R=N*R1
   else raise domainError end
   end
end

% 3.3.2 代入ベースの抽象マシン

% 3.3.3 再帰計算を反復計算に変換すること

declare
fun {Fact N}
   fun {FactIter N A}
      if N==0 then A
      elseif N>0 then {FactIter N-1 A*N}
      else raise domainError end
      end
   end
in
   {FactIter N 1}
end

% 3.4 再帰を用いるプログラミング

% 3.4.1 型の記法



% 3.4.3 アキュムレータ
declare
proc {P X S1 ?Sn}
   if {BaseCase X} then Sn=S1
   else
      {P1 S1 S2}
      {P2 S2 S3}
      {P3 S3 Sn}
   end
end

proc {ExprCode E C1 ?Cn C1 ?Sn}
   case E
   of plus(A B) then C2 C3 S2 S3 in
      C2=plus|C1
      S2=S1+1
      {ExprCode B C2 C3 S2 S3}
      {ExprCode A C3 Cn S3 Sn}
   [] I then
      Cn=plus(I)|C1
      Sn=S1+1
   end
end

fun {MergeSort Xs}
   fun {MergeSortAcc L1 N}
      if N==0 then
	 nil # L1
      elseif N==1 then
	 [L1.1] # L1.2
      elseif N>1 then
	 NL=N div 2
	 NR=N-NL
	 Ys # L2 = {MergeSortAcc L1 NL}
	 Zs # L3 = {MergeSortAcc L2 NR}
      in
	 {Merge Ys Zs} # L3
      end
   end
in
   {MergeSortAcc Xs {Length Xs}}.1
end

% 3.4.4. 差分リスト
declare
fun {AppendD D1 D2}
   S1#E1=D1
   S2#E2=D2
in
   E1=S2
   S1#E2
end

%local X Y in {Browse {AppendD (1|2|3|X)#X (4|5|Y)#Y}} end

fun {Append L1 L2}
   case L1
   of X|T then X|{Append T L2}
   [] nil then L2
   end
end

fun {Flatten Xs}
   case Xs
   of nil then nil
   [] X|Xr andthen {IsList X} then
      {Append {Flatten X} {Flatten Xr}}
   [] X|Xr then
      X|{Flatten Xr}
   end
end

fun {Flatten Xs}
   proc {FlattenD Xs ?Ds}
      case Xs
      of nil then Y in Ds=Y#Y
      [] X|Xr andthen {IsList X} then Y1 Y2 Y4 in
	 Ds=Y1#Y4
	 {FlattenD X Y1#Y2}
	 {FlattenD Xr Y2#Y4}
      [] X|Xr then Y1 Y2 in
	 Ds=(X|Y1)#Y2
	 {FlattenD Xr Y1#Y2}
      end
   end Ys
in {FlattenD Xs Ys#nil} Ys end

fun {Flatten Xs}
   proc {FlattenD Xs ?S E}
      case Xs
      of nil then S=E
      [] X|Xr andthen {IsList X} then Y2 in
	 {FlattenD X S Y2}
	 {FlattenD Xr Y2 E}
      [] X|Xr then Y1 in
	 S=X|Y1
	 {FlattenD Xr Y1 E}
      end
   end Ys
in {FlattenD Xs Ys nil} Ys end

fun {Flatten Xs}
   fun {FlattenD Xs E}
      case Xs
      of nil then E
      [] X|Xr andthen {IsList X} then
	 {FlattenD X {FlattenD Xr E}}
      [] X|Xr then
	 X|{FlattenD Xr E}
      end
   end
in {FlattenD Xs nil} end

fun {Reverse Xs}
   proc {ReverseD Xs ?Y1 Y}
      case Xs
      of nil then Y1=Y
      [] X|Xr then {ReverseD Xr Y1 X|Y}
      end
   end Y1
in {ReverseD Xs Y1 nil} Y1 end
   