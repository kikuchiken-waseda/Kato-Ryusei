#!/usr/bin/perl
use utf8;
use CGI;
use warnings;
use Encode qw(decode);

$query = new CGI;
$ID = $query->param('ID');
$scripts = $query->param('scripts');

$c_text = $scripts;
$c_text =~ s/\r//sig;
$c_text =~ s/\n//sig;
$c_text =~ s/\s//sig;
$c_text =~ s/\xe3\x80\x80//sig;
$length = length(decode('utf8', $c_text));

if ($length < 250){
    print "Content-type:text/html\n\n";
    print "<HTML><HEAD><META HTTP-EQUIV='Content-Type' CONTENT='\text/html;CHARSET=UTF-8'>\n#";
    print "<TITLE>Not Enough Characters</TITLE></HEAD>\n";
    print "<BODY>\n";
    print "<B>$length</B> characters in all.<br>";
    print "<H1>Please input 250 characters at least!</H1><br>";
    print "</BODY>";
    print "</HTML>";
}

else{
print "Content-type:text/html\n\n";
print "<HTML><HEAD><META HTTP-EQUIV='Content-Type' CONTENT='text/html;CHARSET=UTF-8'>\n";
print "<TITLE>Your Speaking style</TITLE></HEAD>\n";
print "<BODY>\n";

$txtname = "$ID-$$";
$maresultsname = "$ID-$$-ma";

open(OUT, ">./txt/$txtname");
print OUT $c_text;
close(OUT);

print "Processing ID:$$";
print "<br>";
print "<br>";
print "<br>";
print "<B>Hi,$ID, your text is:</B>";
print "<br>";
print "<br>";
print $scripts;
print "<br>";
print "<br>";

=pod
print "<B>MA results:</B>";
print "<br>";
print "<br>";
=cut

$maresults = `mecab ./txt/$txtname`;

open(OUT, ">./txt/$maresultsname");
print OUT $maresults;
close(OUT);

open(IN, "<./ref/notation.txt");
while(<IN>){
    $nota[$.-1] = $_;
    $nota[$.-1] =~ s/\n\r//g;
    $nota[$.-1] =~ s/\n//g;
    $nota[$.-1] =~ s/\r//g;
}
close(IN);

$nota0 = quotemeta($nota[0]);
$nota1 = quotemeta($nota[1]);

@first;
@second;

open(IN, "<", "first");
while(<IN>){
    $first[$.-1] = $_;
}
close(IN);
#print @first;
open(IN, "<", "second");
while(<IN>){
    $second[$.-1] = $_;
}
close(IN);

open(IN, "<./txt/$maresultsname");
$ct =0;
while(<IN>){
    if ($_ !~ /$nota0/ && $_ !~ /$nota1/){
    ($morpheme,$u1,$u2,$lemma,$fullpos)=split(/\t+/,$_);   #辞書の内容でスプリットをかけている
    ($pos,$nopos)=split(/-/,$fullpos);   #fullposをさらにスプリットしている
#    print $morpheme;
#    print ",";
    $morphemelist[$ct]=$morpheme;    #morphemeの中身をmorphemelistという配列にしている
#    print $lemma;
#    print",";
    $lemmalist[$ct]=$lemma;          #lemmaを配列にしている
#    print $fullpos;
#    print "<br>";
    $poslist[$ct]=$pos;          #posを配列にしている
    $morphemecount=$ct+1;         #単語の数を数えているだけ
    $ct++;#
    }
}
close(IN);

for ($i=0; $i<$morphemecount-1; $i++){
    $bilemma[$i]=$lemmalist[$i] . $lemmalist[$i+1];   #前後の関係を見るために、lemmalistを2個づつ配列にしている
}

open (IN, "<./ref/lemma-pos.txt");
while(<IN>){
    $lp[$.-1] = $_;
    $lp[$.-1] =~ s/\n\r//g;
    $lp[$.-1] =~ s/\n//g;
    $lp[$.-1] =~ s/\r//g;
}
close (IN);

open (IN, "<./ref/pos-lemma.txt");
while(<IN>){
    $pl[$.-1] = $_;
    $pl[$.-1] =~ s/\n\r//g;
    $pl[$.-1] =~ s/\n//g;
    $pl[$.-1] =~ s/\r//g;
}
close (IN);

open (IN, "<./ref/morpheme-pos.txt");
while(<IN>){
    $mp[$.-1] = $_;
    $mp[$.-1] =~ s/\n\r//g;
    $mp[$.-1] =~ s/\n//g;
    $mp[$.-1] =~ s/\r//g;
}
close (IN);

open (IN, "<./ref/pos-morpheme.txt");
while(<IN>){
    $pm[$.-1] = $_;
    $pm[$.-1] =~ s/\n\r//g;
    $pm[$.-1] =~ s/\n//g;
    $pm[$.-1] =~ s/\r//g;
}
close (IN);

open (IN, "<./ref/lemma-bi.txt");
while(<IN>){
    $lb[$.-1] = $_;
    $lb[$.-1] =~ s/\n\r//g;
    $lb[$.-1] =~ s/\n//g;
    $lb[$.-1] =~ s/\r//g;
}
close (IN);

print"<br>";

%uniq;
foreach $item(@poslist){
    $uniq{$item}=0;
}
@uniqposlist=keys(%uniq);

foreach $key(@poslist){
    $uniq{$key}=$uniq{$key}+1;
}

$adno=0;
$aux=0;
$adv=0;
$v=0;
$par=0;
$pref=0;
$pron=0;
$adj=0;
$int=0;
$suf=0;
$noun=0;
$conj=0;

print"<B>Summary:</B><br>";
print"<br>";
print"Pos and Percentage:<br>";

while( ($name, $value) = each %uniq ){
    $per=sprintf("%.2f",$value/$morphemecount);
#    $per=$value/$morphemecount;

    if($name eq $nota[2]){    #
    $adno = $value;
    }
    if($name eq $nota[3]){
        $aux = $value;
    }
    if($name eq $nota[4]){
        $adv = $value;
    }
    if($name eq $nota[5]){
        $v = $value;
    }
    if($name eq $nota[6]){
        $par = $value;
    }
    if($name eq $nota[7]){
        $pref = $value;
    }
    if($name eq $nota[8]){
        $pron = $value;
    }
    if($name eq $nota[9]){
        $adj = $value;
    }
    if($name eq $nota[10]){
        $int = $value;
    }
    if($name eq $nota[11]){
        $suf = $value;
    }
    if($name eq $nota[12]){
        $noun = $value;
    }
    if($name eq $nota[13]){
        $conj = $value;
    }
#    print "$name:$per<br>";
    print $name.": ";
    print "$per<br>";
}

print"<br>";
print"<B>$morphemecount</B>　　morphemes in all.<br>";
print "<B>$length</B> 　characters in all.<br>";
print "<br>";
print "<br>";

$func = $par+$aux+$conj+$adno+$pref+$suf;
$nnc=$morphemecount-$noun;

$desu=0;
$masu=0;
$tyau=0;
$ne=0;
$yo=0;
$kekko=0;
$jya=0;
$toiu=0;
$yone=0;
$keredomo=0;
$toka=0;
$terute=0;
$tteiu=0;

foreach $bilemma(@bilemma){###bilemmaは前後二つセットのもの　　　　例「と+言う」「言う+ので」
    if ($bilemma eq $lb[0]){#と言う
    $toiu++;
    }
    if ($bilemma eq $lb[1]){#よね
        $yone++;
    }
    if ($bilemma eq $lb[2]){#けれども
        $keredomo++;
    }
    if ($bilemma eq $lb[3]){#とか
        $toka++;
    }
    if ($bilemma eq $lb[4]){#てるて
        $terute++;
    }
    if ($bilemma eq $lb[5]){#って言う
        $tteiu++;
    }
}

$f=0;

foreach $lemmalist(@lemmalist){#こっちは一単語だから、lmmalistを使っている
    $f++;
    if ($lemmalist eq $lp[0] && $poslist[$f-1] eq $pl[0]){#lpです    #plは助動詞
        $desu++;
    }
    if ($lemmalist eq $lp[1] && $poslist[$f-1] eq $pl[1]){#ます       #助動詞
        $masu++;
    }
    if ($lemmalist eq $lp[2] && $poslist[$f-1] eq $pl[2]){#ちゃう      #助動詞
        $tyau++;
    }
    if ($lemmalist eq $lp[3] && $poslist[$f-1] eq $pl[3]){#ね        #助詞
        $ne++;
    }
    if ($lemmalist eq $lp[4] && $poslist[$f-1] eq $pl[4]){#よ      #助詞
        $yo++;
    }
    if ($lemmalist eq $lp[5] && $poslist[$f-1] eq $pl[5]){#結構     #副詞
        $kekko++;
    }
}

$g=0;
foreach $morphemelist(@morphemelist){
    $g++;
    if ($morphemelist eq $mp[0] && $poslist[$g-1] eq $pm[0]){##mpじゃ   + #助詞
        $jya++;
    }
}

$SSI = 35.1*$keredomo+19.01*$yone-15.16*$tteiu+12.79*$toiu+12.33*$jya-11.3*$adno-11.16*$kekko-9.21*$yo+7.65*$desu+7.65*$masu-7.44*$ne-6.02*$terute-4.63*$aux+3.67*$func+3.13*$adv+2.24*$v+1.09*$par;

$SSF = -25.09*$keredomo-19.92*$desu-19.92*$masu+19.79*$yo+17.66*$tyau-16.13*$kekko+14.19*$ne+12.26*$pref+10.63*$adno+9.06*$toka+6.69*$aux-5.79*$func-5.46*$toiu+4.54*$pron+2.69*$adj;

$SSC = 34.06*$keredomo-21.21*$yo-13.86*$tyau+11.34*$desu+11.34*$masu-11.31*$adno-9.44*$toka-7.87*$terute-7.04*$aux-6.1*$ne+4.89*$func-2.84*$adj-1.51*$int;


$I = sprintf("%.2f",$SSI/$nnc-3.09);
$F = sprintf("%.2f",$SSF/$nnc+2.72);
$C = sprintf("%.2f",$SSC/$nnc-1.78);

print"<font size = '5' color = '#ff0000' face = 'Impact'><B>Your Speaking style:</B></font><br>";
print"<br>";
print"<B>Familiarity (親しさ):　　　　　</B>"."$F";
print"<br>";
print"<B>Intelligibility-oriented (明瞭さ): 　</B>"."$I";
print"<br>";
print"<B>soCial strata (社会階層):　　</B>"."$C";
print"<br>";
print"<br>";

#plotting data
$PF=$F+3;
$PI=$I+3;
$PC=$C+3;

#$setdir = "./udb/$ID";
#mkdir($setdir,0777);


open(OUT, ">>./udb/$ID");
print OUT $$.",".$PF.",".$PI.",".$PC."\n";
close(OUT);

@logn;

open(IN, "<./udb/$ID");
=pod
while(<IN>){
    $logn[$.-1]=$_;
}
$numlogn = $#logn + 1;
print $numlogn;

close(IN);
=cut
while(<IN>){
       ($logp,$logF,$logI,$logC)=split(/,/,$_);
        $Flist[$.-1]=$logF;
        $Ilist[$.-1]=$logI;
        $Clist[$.-1]=$logC;
}
$logcount=$.;
print $logcount;
print "\n";
close(IN);

#print @Flist;
#print @Ilist;
#print @Clist;


#$htmlfile=$ID."-".$$.".html";
$htmlfile=$ID.".html";

$logco=0;
open(OUT, ">./udb/$htmlfile");
print OUT @first;
while($logco < $logcount){
#    print OUT "gData[$logco]={x:".$Flist[$logco].",y:".$Ilist[$logco].",z:".$Clist[$logco]."};\n";
    print OUT "gData[";
    print OUT $logco;
    print OUT "]={x:";
    print OUT $Flist[$logco];
    print OUT ",y:";
    print OUT $Ilist[$logco];
    print OUT ",z:";
    print OUT $Clist[$logco];
    print OUT "};\n";

    $logco++;
}

print OUT @second;
close(OUT);

print "<A HREF='http://shinzan.human.waseda.ac.jp/~raymond/speakingstyle/udb/$htmlfile ' TARGET='_blank' >Plot!</A>";

print "</BODY>";
print "</HTML>";
}
