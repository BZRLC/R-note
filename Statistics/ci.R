n=25
reps=100
conf.level=0.95

dat <- matrix(rnorm(n*reps, mean=100, sd=10)

rmeans <- rowMeans(dat)

# 双边检验, 左边 qnorm(0.025,x_bar,sd_hat)
lower <- qnorm((1-conf.level)/2, rmeans, 10/sqrt(n))

# 右边 qnorm(0.975,x_bar,sd_hat)
upper <- qnorm(1-(1-conf.level)/2, rmeans, 10/sqrt(n))

xr <- 100 + 4.5*c(-1,1)*10/sqrt(n)
    
plot(lower,seq(1,reps), type="n", xlim=xr, xlab="Confidence Interval",ylab="Index")
 
abline( v= qnorm(c((1-conf.level)/2,1-(1-conf.level)/2), 100,
                  10/sqrt(n)), col='lightgreen')
 
title( main=paste("Confidence intervals based on z distribution"))

 
colr <- ifelse( lower > 100, 'blue', ifelse( upper < 100, 'red', 'black') )
    
abline(v=100)
    
segments(lower,1:reps,upper,1:reps, col=colr)
points( rmeans, seq(along=rmeans), pch='|', col=colr )
