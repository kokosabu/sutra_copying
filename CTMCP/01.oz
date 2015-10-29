{Browse 9999*9999}

declare
V=9999*9999
{Browse V*V}

{Browse 1*2*3*4*5*6*7*8*9*10}

declare
fun {Fact N}
   if N==0 then 1 else N*{Fact N-1} end
end

{Browse {Fact 10}}
{Browse {Fact 100}}

declare
fun {Comb N K}
   {Fact N} div ({Fact K}*{Fact N-K})
end

{Browse {Comb 10 3}}

{Browse [5 6 7 8]}

declare
H = 5
T = [6 7 8]
{Browse H|T}

declare
L = [5 6 7 8]
{Browse L.1}
{Browse L.2}   # [6 7 8]
{Browse L.2.2} # [7 8]

declare
L = [5 6 7 8]
case L of H|T then {Browse H} {Browse T} end


declare Pascal AddList ShiftLeft ShiftRight
fun {Pascal N}
   if N == 1 then [1]
   else
      {AddList {ShiftLeft {Pascal N-1}} {ShiftRight {Pascal N-1}}}
   end
end

fun {ShiftLeft L}
   case L of H|T then
      H|{ShiftLeft T}
   else [0] end
end

fun {ShiftRight L} 0|L end

fun {AddList L1 L2}
   case L1 of H1|T1 then
      case L2 of H2|T2 then
	 H1+H2|{AddList T1 T2}
      end
   else nil end
end

{Browse {Pascal 20}}

% 1.7 計算量

declare
fun {FastPascal N}
   if N==1 then [1]
   else L in
      L = {FastPascal N-1}
      {AddList {ShiftLeft L} {ShiftRight L}}
   end
end

{Browse {Pascal 30}}
{Browse {FastPascal 30}}

% 1.8 遅延計算

declare
fun lazy {Ints N}
   N|{Ints N+1}
end

L={Ints 0}
{Browse L}

{Browse L.1}

case L of A|B|C|_ then {Browse A+B+C} end


declare
fun lazy {PascalList Row}
   Row|{PascalList
	{AddList {ShiftLeft Row} {ShiftRight Row}}}
end

L={PascalList [1]}
{Browse L}

{Browse L.1}
{Browse L.2.1}


declare
fun {PascalList2 N Row}
   if N==1 then [Row]
   else
      Row|{PascalList2 N-1
	   {AddList {ShiftLeft Row} {ShiftRight Row}}}
   end
end


% 1.9 高階プログラミング

declare
fun {GenericPascal Op N}
   if N==1 then [1]
   else L in
      L={GenericPascal Op N-1}
      {OpList Op {ShiftLeft L} {ShiftRight L}}
   end
end

fun {OpList Op L1 L2}
   case L1 of H1|T1 then
      case L2 of H2|T2 then
	 {Op H1 H2}|{OpList Op T1 T2}
      end
   else nil end
end

fun {Add X Y} X+Y end

fun {FastPascal N} {GenericPascal Add N} end

fun {Xor X Y} if X==Y then 0 else 1 end end


% 1.10 並列性

declare
thread P in
   P={Pascal 30}
   {Browse P}
end
{Browse 99*99}

% 1.11 データフロー

declare X in
thread {Delay 10000} X=99 end
{Browse start} {Browse X*X}

declare X in
thread {Browse start} {Browse X*X} end
{Delay 10000} X=99

% 1.12 明示的状態

declare
C={NewCell 0}
C:=@C+1
{Browse @C}

declare
C={NewCell 0}
fun {FastPascal N}
   C:=@C+1
   {GenericPascal Add N}
end
{Browse {FastPascal 5}}

% 1.13 オブジェクト

declare
local C in
   C={NewCell 0}
   fun {Bump}
      C:=@C+1
      @C
   end
   fun {Read}
      @C
   end
end

declare
fun {FastPascal N}
   {Browse {Bump}}
   {GenericPascal Add N}
end

% 1.14 クラス

declare
fun {NewCounter}
   C Bump Read in
   C={NewCell 0}
   fun {Bump}
      C:=@C+1
      @C
   end
   fun {Read}
      @C
   end
   counter(bump:Bump read:Read)
end

declare
Ctr1={NewCounter}
Ctr2={NewCounter}

{Browse {Ctr1.bump}}

% 1.15 非決定性と時間

declare
C={NewCell 0}
thread
   C:=1
end
thread
   C:=2
end

declare
C={NewCell 0}
thread I in
   I=@C
   C:=I+1
end
thread J in
   J=@C
   C:=J+1
end

declare
C={NewCell 0}
L={NewLock}
thread
   lock L then I in
      I=@C
      C:=I+1
   end
end
thread
   lock L then J in
      J=@C
      C:=J+1
   end
end

% 1.18 練習問題
% 1. 計算器
% 1. (a)

declare A B C D E
A = 2 * 2 * 2 * 2 % 2^4
B = A * A         % 2^8
C = B * B         % 2^16
D = C * C         % 2^32
E = D * D         % 2^64
{Browse A*D*E}

% 1. (b)
% スターリングの公式を利用すると近似計算できる
{Browse 1*2*3*4*5*6*7*8*9*10*11*12*13*14*15*16*17*18*19*20
 *21*22*23*24*25*26*27*28*29*30*31*32*33*34*35*36*37*38*39*40
 *41*42*43*44*45*46*47*48*49*50*51*52*53*54*55*56*57*58*59*60
 *61*62*63*64*65*66*67*68*69*70*71*72*73*74*75*76*77*78*79*80
 *81*82*83*84*85*86*87*88*89*90*91*92*93*94*95*96*97*98*99*100}

% 2. 組み合わせの計算
% 2. (a)
declare Comb Fact2
fun {Comb N K}
   {Fact2 N N K} div {Fact K}
end
fun {Fact2 N M K}
   if N==M-K+1 then
      N
   else
      N * {Fact2 N-1 M K}
   end
end

%{Browse {Comb 6 3}}
%{Browse {Comb 6 0}}

% 2. (b)
declare Comb Fact2 X
fun {Comb N K}
   if K==0 then
      1
   else
      if K+K > N then
	 {Fact2 N N K} div {Fact K}
      else
	 {Fact2 N N K} div {Fact N-K}
      end
   end
end
fun {Fact2 N M K}
   if N==M-K+1 then
      N
   else
      N * {Fact2 N-1 M K}
   end
end

%{Browse {Comb 6 3}}
%{Browse {Comb 6 0}}

% 3. プログラムの正しさ
% {Pascal 1}は正しい答え、すなわち[1]を返す。
% {Pascal N}の{Pascan N-1}が正しいと仮定する。
% {AddList {ShiftLeft {Pascal N-1}} {ShiftRight {Pascal N-1}}}を
% 計算する。{Pascal N-1}は仮定により正しい答えを返す。
% よって、{Pascal N-1}を左に1つずらしたものと右に1つずらしたものを
% 加算した結果が正しいとすれば{Pascal N}も正しい答えを返す。

% 4. プログラムの計算量
% 計算量が大きい場合はハードウェアで対処するのではなく、
% 効率の良いアルゴリズムを検討するべき。
% --
% 非常な小さな値であれば実用的である。
% --
% どうしても計算するようであれば、計算量の大きな
% プログラムを走らせなければならないと考える。

% 5. 遅延計算
declare Ints SumList
fun lazy {Ints N}
   N|{Ints N+1}
end
fun {SumList L}
   case L of X|L1 then X+{SumList L1}
   else 0 end
end

% {Show {SumList {Ints 0}}}
% {Show {SumList {Ints 0}}}
% {Show {SumList [1 2 3]}}
% {Show [1 2 3]}
% {Show {SumList {Ints 0}}}
% -> とまらなくなる Lの評価がずっとさだまらないということか?
% {Show {SumList [1 2 3]}}
% -> 6

% 6. 高階プログラミング
% 6. (a)
declare OpList ShiftLeft ShiftRight
fun {GenericPascal Op N}
   if N==1 then [1]
   else L in
      L={GenericPascal Op N-1}
      {OpList Op {ShiftLeft L} {ShiftRight L}}
   end
end
fun {Sub X Y} X-Y end
fun {Mul X Y} X*Y end
fun {Mul1 X Y} (X+1) * (Y+1) end

fun {OpList Op L1 L2}
   case L1 of H1|T1 then
      case L2 of H2|T2 then
	 {Op H1 H2}|{OpList Op T1 T2}
      end
   else nil end
end
fun {ShiftLeft L}
   case L of H|T then
      H|{ShiftLeft T}
   else [0] end
end
fun {ShiftRight L} 0|L end

% {Show {GenericPascal Sub 3}}
% {Show {GenericPascal Mul 3}}
% Mulが0だけになってしまうのは
% [0 1]
% [1 0]
% の掛け算になるから。
% {Show {GenericPascal Mul1 3}}

% 6. (b)
% for I in 1..10 do {Browse {GenericPascal Op I}} end
for I in 1..10 do {Show {GenericPascal Sub I}} end
for I in 1..10 do {Show {GenericPascal Mul I}} end
for I in 1..10 do {Show {GenericPascal Mul1 I}} end

% 7. 明示的状態
local X in
   X=23
   local X in
      X=44
   end
   {Browse X}
   %{Show X}
end
% -> 23
% スコープの問題。Xが2つあるが、表示しているのは1個目

local X in
   X={NewCell 23}
   X:=44
   {Browse @X}
   %{Show @X}
end
% -> 44
% 上書きされた44が表示

% 8. 明示的状態と関数
declare
fun {Accumulate N}
   Acc in
   Acc={NewCell 0}
   Acc:=@Acc+N
   @Acc
end
% 関数が呼ばれるたびにAccが再宣言されていることが問題

declare Acc
Acc={NewCell 0}
fun {Accumulate N}
   Acc:=@Acc+N
   @Acc
end

{Show {Accumulate   5}}
{Show {Accumulate 100}}
{Show {Accumulate  45}}

% 9. 記憶域
% 9. (a)
declare
S={NewStore}
{Put S 2 [22 33]}
%{Browse {Get S 2}}
%{Browse {Size S}}
{Show {Get S 2}}
{Show {Size S}}

% 9. (b)
declare FasterPascal ShiftLeft ShiftRight AddList S
S={NewStore}
fun {FasterPascal N}
M in
   M = {Size S}
   if N>M then
      if N==1 then
	 {Put S N [1]}
	 [1]
      else L ANS in
	 L   = {FasterPascal N-1}
	 ANS = {AddList {ShiftLeft L} {ShiftRight L}}
	 {Put S N ANS}
	 ANS
      end
   else
      {Get S N}
   end   
end
fun {ShiftLeft L}
   case L of H|T then
      H|{ShiftLeft T}
   else [0] end
end
fun {ShiftRight L} 0|L end
fun {AddList L1 L2}
   case L1 of H1|T1 then
      case L2 of H2|T2 then
	 H1+H2|{AddList T1 T2}
      end
   else nil end
end

{Show {FasterPascal 10}}

% 9. (c)
declare
local S in
   S={NewCell nil}
   fun {MyNewStore}
      S
   end
   % Cellを変更する関数は特殊?
   proc {Put S N X}
      S:=N|X|@S
   end
   fun {Get S N}
      case @S of N1|X|L then
	 if N==N1 then
	    X
	 else
	    {Get2 L N}
	 end
      else
	 nil
      end
   end
   fun {Get2 S N}
      case S of N1|X|L then
	 if N==N1 then
	    X
	 else
	    {Get L N}
	 end
      else
	 nil
      end
   end
   fun {Size S}
      case @S of N|X|L then
	 1 + {Size2 L}
      else
	 0
      end
   end
   fun {Size2 S}
      case S of N|X|L then
	 1 + {Size2 L}
      else
	 0
      end
   end
end

X={MyNewStore}
{Put X 2 [22 33]}
{Put X 3 [33 44]}
{Show {Get X 2}}
{Show {Size X}}
%{Browse {Get X 2}}
%{Browse {Size X}}

% 9. (d)
declare
local C in
   C={NewCell 0}
   proc {Bump}
      C:=@C+1
      %@C
   end
   fun {Read}
      @C
   end
end
local S in
   S={NewCell nil}
   fun {MyNewStore}
      S
   end
   % Cellを変更する関数は特殊?
   proc {Put S N X}
      S:=N|X|@S
      {Bump}
   end
   fun {Get S N}
      case @S of N1|X|L then
	 if N==N1 then
	    X
	 else
	    {Get2 L N}
	 end
      else
	 nil
      end
   end
   fun {Get2 S N}
      case S of N1|X|L then
	 if N==N1 then
	    X
	 else
	    {Get L N}
	 end
      else
	 nil
      end
   end
   fun {Size S}
      {Read}
   end
end

X={MyNewStore}
{Put X 2 [22 33]}
{Put X 3 [33 44]}
%{Show {Get X 2}}
%{Show {Size X}}
{Browse {Get X 2}}
{Browse {Size X}}

% 10. 明示的状態と並列性
% 10. (a)
% 2ばかりで1になることは無かった。
% C={NewCell}
% I=@C
% C:=I+1
% J=@C
% C:=J+1
% という流れで動いていると考えられる。

% 10. (b)
% 確実とは言えないがこれで高確率で1になる。
declare
C={NewCell 0}
thread I in
   I=@C
   {Delay 10}
   C:=I+1
end
thread J in
   J=@C
   {Delay 10}
   C:=J+1
end

% {Browse @C}

% 10. (c)
% ロックをかけてあるので1にするのは不可能。
% Delayをしても速度が遅くなるのみ。
declare
C={NewCell 0}
L={NewLock}
thread
   {Delay 100}
   lock L then I in
      I=@C
      C:=I+1
   end
end
thread
   lock L then J in
      J=@C
      {Delay 100}
      C:=J+1
   end
end