% 2 宣言的計算モデル
% 2.1 実用的プログラミング言語の定義
% 2.1.1 言語の構文
% 2.1.2 言語の意味

% 2.4 核言語の意味
% 2.4.1 基本概念
local Y LB in
   Y=10
   proc {LB X ?Z}
      if X>=Y then Z=X else Z=Y end
   end
   local Y=15 Z in
      {LB 5 Z}
   end
end

% 2.5 メモリ管理
% 2.5.1 末尾呼び出し最適化
declare Loop10
proc {Loop10 I}
   if I==10 then skip
   else
      {Browse I}
      {Loop10 I+1}
   end
end
{Loop10 0}
% 2.5.2 メモリライフサイクル
% 2.5.3 ガーベッジコレクション
% 2.5.4 ガーベッジコレクションは魔術ではない
declare L Sum
%L=[1 2 3 ... 1000000]
L=[1 2 3 4 5 6 7 8 9 10]
fun {Sum X L1 L}
   case L1 of Y|L2 then {Sum X+Y L2 L}
   else X end
end
{Browse {Sum 0 L L}}

declare Sum
fun {Sum X L1}
   case L1 of Y|L2 then {Sum X+Y L2}
   else X end
end
{Browse {Sum 0 L}}
% 2.5.5 Mozartのガーベッジコレクタ
% 2.6 核言語から実用言語へ
% 2.6.1 構文上の便宜
% 2.6.2 関数(fun文)
declare
fun {Max X Y}
   if X>=Y then X else Y end
end
%{Show {Max 10 3}}
%{Show {Max 3 10}}
declare
proc {Max X Y ?R}
   R = if X>=Y then X else Y end
end
%{Show {Max 10 3}}
%{Show {Max 3 10}}
declare
proc {Max X Y ?R}
   if X>=Y then R=X else R=Y end
end
%{Show {Max 10 3}}
%{Show {Max 3 10}}

% {Q {F X1 ... XN} ...}
% local R in
%    {F X1 ... XN R}
%    {Q R ...}
% end

% Ys={F X}|{Map Xr F}
% local Y Yr in
%    Ys=Y|Yr
%    {F X Y}
%    {Map Xr F Yr}
% end
declare
fun {Map Xs F}
   case Xs
   of nil then  nil
   [] X|Xr then {F X}|{Map Xr F}
   end
end
% {Browse {Map [1 2 3 4] fun {$ X} X*X end}}
declare
proc {Map Xs F ?Ys}
   case Xs of nil then Ys=nil
   else case Xs of X|Xr then
	   local Y Yr in
	      Ys=Y|Yr {F X Y} {Map Xr F Yr}
	   end
	end end
end
% 2.6.3 対話的インタフェース(declare文)
declare A B C in
C=A+B
% {Browse C}

% 2.9 練習問題
% 1. 自由変数と束縛変数
proc {P X}
   if X>0 then {P X-1} end
end
% ([({P X}, {P -> p, X -> x})],
%  {p = (proc {$ X} <s1> end, φ), x})
% 束縛

% 2. 文脈的環境
declare MulByN N in
N=3
proc {MulByN X ?Y}
   Y=N*X
end


declare A B
A=10
{MulByN A B}