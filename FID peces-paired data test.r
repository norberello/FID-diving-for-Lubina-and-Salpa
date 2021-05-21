#librerias necesarias
library(ggplot2)#gramatica de graficos
library(repr)#para controlar el aspecto de la fuente, graficos etc...
library(gridExtra)#para organizar plots
library(lmtest)#test de independencia
library(car)#homogenedidad de varianza y otras funciones

options(repr.plot.width=14)#graficos mas anchos

#cargamos los datos
data.peces<-read.csv("mikeldata.csv")#para graficos y test
data.peces.w<-read.csv("mikeldata_wide.csv")#formato ancho, mas facil para hacer sumarios por especie

head(data.peces,10)#primeras 10 lineas de datos
str(data.peces)#estructura de los datos

summary(data.peces.w$Lub_FID)
summary(data.peces.w$Sal_FID)
sd(data.peces.w$Lub_FID)
sd(data.peces.w$Sal_FID)

a<-ggplot(data.peces, aes(x=Especie, y=FID, fill=Especie)) +
    geom_boxplot(alpha=0.7) + geom_jitter(width = 0.1)+
    stat_summary(fun=mean, geom="point", shape=4, size=10, color="black", fill="red") +
    theme(legend.position="none")+ theme_bw()+ ggtitle("a")+theme(legend.position = "none")
#la cruz indica la media
b<-ggplot(data.peces, aes(x=Especie, y=min, fill=Especie)) + geom_jitter(width = 0.1)+
    geom_boxplot(alpha=0.7) +ggtitle("b")+
    stat_summary(fun=mean, geom="point", shape=4, size=10, color="black", fill="red") +
    theme(legend.position="none")+ theme_bw()+ theme(legend.position = "none")
c<-ggplot(data.peces, aes(x=Especie, y=max, fill=Especie)) +
    geom_boxplot(alpha=0.7) + geom_jitter(width = 0.1)+
    stat_summary(fun=mean, geom="point", shape=4, size=10, color="black", fill="red") +
    theme(legend.position="none")+ theme_bw()+ggtitle("c")+theme(legend.position = "none")

library(gridExtra)
grid.arrange(a,b,c,ncol=3)

#centremonos en solos FID, normalidad
d<-ggplot(data.peces,aes(x=FID,fill=Especie))+
  geom_density(alpha=0.6)+theme_bw()+ggtitle("a")+theme(legend.position = "none")
#los FID no son normales, particularmente para la salpa

e<-ggplot(data.peces, aes(x=FID)) +
  geom_histogram(aes(y=..density..,fill=Especie), color="grey30",alpha=0.6)+
  stat_density(geom="line")+
  facet_grid(Especie~.)+ggtitle("b")

f<-ggplot(data.peces, aes(sample = FID,color=Especie,alpha=0.6))+stat_qq() + stat_qq_line() + theme_bw()+
ggtitle("c")+ theme(legend.position = "none")

# Multiple ECDFs
g<-ggplot(data.peces, aes(FID, colour = Especie)) + stat_ecdf()+theme_bw()+ggtitle("d")

grid.arrange(d,e,f,g,ncol=2)

shapiro.test(data.peces.w$Lub_FID)#problemas de normalidad
shapiro.test(data.peces.w$Sal_FID)

leveneTest(FID~Especie,data=data.peces)#no hay problemas de homogenedidad de varianza de IID entre Especies

dwtest(FID~Especie,data=data.peces)#problemas de independencia de observaciones

#paired t-test
wilcox.test(FID~Especie,data=data.peces,exact = F,paired = T)#AJA!

t.test(log10(FID)~Especie,data=data.peces,exact = F,paired = T)
#se podrían tranformar los datos con logarítmos, pero es más díficl de intepretar. Quizas se puede añadir para dar más fuerza al resultado.

#tamaño del efecto
Zstat<-qnorm(0.07744/2)
eff.size<-abs(Zstat)/sqrt(23)
eff.size#tamaño del efecto moderado

#analisis de la potencia conseguida con el test en base a n y el tamaño del efecto
library(pwr)
(p.out<-pwr.t.test(d=eff.size,sig.level=.05, n = 23,type=c("paired")))
#tenemos una potencia baja, es decir hay cierto riego de tener un falso positivo
#si el test no hubiera dado diferencias, tendriamos el riesgo de tener un falso negativo

(p.out2<-pwr.t.test(d=eff.size,sig.level=.05, power = 0.8,type=c("paired")))
plot(p.out2)
#para ese tamano del efecto y una potencia optima de 0.8 hubieramos necesitado una muesta de 59 pescadores

summary(data.peces.w$Lub_FID)
summary(data.peces.w$Sal_FID)

data.peces.w<-read.csv("mikeldata_wide.csv")#formato ancho, mas facil para hacer sumarios por especie
data.peces.w

table(data.peces.w$tamano)

#una persona no respondio, es interesante encontrar una persona que hace submarinismo para no para cazar.
#comparemos entonces 21 frente a 1, aunque no sea evidente hagamos el análisis.

#Binomial exact goodness of fit test
n <- 21
k <- 1
p <- 0.5

x <- seq(0, n)
y <- dbinom(x,
            size = n,
            prob = p)

barplot(height = y,
        names.arg = x,
        col = "deepskyblue",
        main = "Probabilidad de preferir peces pequeños",
        xlab = "Numero de personas",
        ylab = "Probabilidad de bajo la hipótesis nula",
        las = 1)
        #la probabilidad de que una persona de 22 prefiera cazar peces pequenos es muy baja

binom.test(k, n,p = p,alternative = "two.sided",conf.level = 0.95)

citation("pwr")

citation("ggplot2")

#para citar R
citation()
