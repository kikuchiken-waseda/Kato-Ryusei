FAOMFUN1 <- read.csv("FAOMFUN1disfluency.csv")
FAOMFUN2 <- read.csv("FAOMFUN2disfluency.csv")
FAOMNAN1 <- read.csv("FAOMNAN1disfluency.csv")
FAOMNAN2 <- read.csv("FAOMNAN2disfluency.csv")
MAKMTKN1 <- read.csv("MAKMTKN1disfluency.csv")
MAKMTKN2 <- read.csv("MAKMTKN2disfluency.csv")
MTKMTTF1 <- read.csv("MTKMTTF1disfluency.csv")
MTKMTTF2 <- read.csv("MTKMTTF2disfluency.csv")

summary(FAOMFUN1$words)
FAOMFUN1$X

"pauses, repairs, fillers, word fragments,repeats, fresh starts"

"音韻の引き伸ばし,フィラー, 語の中断, 語句の繰り返し, 語句の言い直し  "
" fillers, prolongation, repetitions, repairs, "
disfluency <- FAOMFUN1$X
before <- rbind(FAOMFUN1$words,FAOMNAN1$words, MAKMTKN1$words, MTKMTTF1$words)
after <- rbind(FAOMFUN2$words,FAOMNAN2$words, MAKMTKN2$words, MTKMTTF2$words)
before
after

#音韻の引き伸ばし
var.test(before[,1],after[,1])
#p-value = 0.9912
t.test(before[,1],after[,1])
#p-value = 0.6077

help("var.test")
#フィラー　　
var.test(before[,2],after[,2])
#p-value = 0.2542
t.test(before[,2],after[,2],var.equal = FALSE)
#p-value = 0.5906

#語の中断　　
var.test(before[,3],after[,3])
#p-value = 0.7136
t.test(before[,3],after[,3],var.equal = FALSE)
#p-value = 0.8981

#語句の繰り返し 
var.test(before[,4],after[,4])
#p-value = 0.6725
t.test(before[,4],after[,4],var.equal = FALSE)
#p-value = 0.6752

#語句の言い直し 
var.test(before[,5],after[,5])
#p-value = 0.3562
t.test(before[,5],after[,5],var.equal = FALSE)
# p-value = 0.07575



FAOMFUN1$words
FAOMNAN1$words
MAKMTKN1$words
MTKMTTF1$words

FAOMFUN2$words
FAOMNAN2$words
MAKMTKN2$words
MTKMTTF2$words


#男女と男男　全体
MFbefore <-FAOMFUN1$words + FAOMNAN1$words
MFafter <-FAOMFUN2$words + FAOMNAN2$words
MMbefore <-MAKMTKN1$words + MTKMTTF1$words
MMafter <- MAKMTKN2$words + MTKMTTF2$words
#半年前と後　全体
before <- FAOMFUN1$words + FAOMNAN1$words + MAKMTKN1$words + MTKMTTF1$words
after <- FAOMFUN2$words + FAOMNAN2$words + MAKMTKN2$words + MTKMTTF2$words
#男女　全体
MF <-FAOMFUN1$words + FAOMNAN1$words + FAOMFUN2$words + FAOMNAN2$words
MM <-MAKMTKN1$words + MTKMTTF1$words + MAKMTKN2$words + MTKMTTF2$words

#分析

#半年前と半年後　個別
#男女1
var.test(FAOMFUN1$words,FAOMFUN2$words)
#等分散が仮定できる  p-value = 0.6155
t.test(FAOMFUN1$words,FAOMFUN2$words, var.equal = TRUE, paired=TRUE)
#p-value = 0.5879

#男女2
var.test(FAOMFUN1$words,FAOMFUN2$words)
#p-value = 0.6155
t.test(FAOMFUN1$words,FAOMFUN2$words, var.equal = TRUE, paired=TRUE)
#p-value = 0.5879

#男男3
var.test(MAKMTKN1$words,MAKMTKN2$words)
# p-value = 0.8865
t.test(MAKMTKN1$words,MAKMTKN2$words, var.equal = TRUE, paired=TRUE)
#p-value = 0.6885

#男男4
var.test(MTKMTTF1$words,MTKMTTF2$words)
#p-value = 0.3843
t.test(MTKMTTF1$words,MTKMTTF2$words, var.equal = TRUE, paired=TRUE)
#p-value = 0.6195



#男女と男男　全体
#男女でまとめた半年前と後
var.test(MFbefore,MFafter)
#p-value = 0.9166
t.test(MFbefore,MFafter, var.equal = TRUE, paired=TRUE)
#p-value = 0.7166

#男男でまとめた半年前と後
var.test(MMbefore,MMafter)
#p-value = 0.6225
t.test(MMbefore,MMafter, var.equal = TRUE, paired=TRUE)
#p-value = 0.6678

#半年前の男女と半年後の男男
var.test(MFbefore,MMafter)
#p-value = 0.3722
t.test(MFbefore,MMafter, var.equal = TRUE)
#p-value = 0.5547

#半年前の男男と半年後の男女
var.test(MFbefore,MFafter)
#p-value = 0.9166
t.test(MFbefore,MFafter, var.equal = TRUE)
#p-value = 0.9613



#半年前半年後　全体
var.test(before, after)
#p-value = 0.7812
t.test(before,after, var.equal = TRUE, paired=TRUE)
#p-value = 0.9589



#男女　全体
var.test(MF, MM)
#p-value = 0.561
t.test(MF,MM, var.equal = TRUE, paired=TRUE)
#p-value = 0.561

