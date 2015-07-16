traveltime <- read.csv('traffic_cumulative_time2.csv')
traveltimesum <- read.csv('traffic_calibrated_average_time_summary.csv',header=TRUE)

# Test residuals of the model
plotForecastErrors <- function(forecasterrors)
{
  # make a histogram of the forecast errors:
  mybinsize <- IQR(forecasterrors)/4
  mysd   <- sd(forecasterrors)
  mymin  <- min(forecasterrors) - mysd*5
  mymax  <- max(forecasterrors) + mysd*3
  # generate normally distributed data with mean 0 and standard deviation mysd
  mynorm <- rnorm(10000, mean=0, sd=mysd)
  mymin2 <- min(mynorm)
  mymax2 <- max(mynorm)
  if (mymin2 < mymin) { mymin <- mymin2 }
  if (mymax2 > mymax) { mymax <- mymax2 }
  # make a red histogram of the forecast errors, with the normally distributed data overlaid:
  mybins <- seq(mymin, mymax, mybinsize)
  hist(forecasterrors, col="red", freq=FALSE, breaks=mybins)
  # freq=FALSE ensures the area under the histogram = 1
  # generate normally distributed data with mean 0 and standard deviation mysd
  myhist <- hist(mynorm, plot=FALSE, breaks=mybins)
  # plot the normal curve as a blue line on top of the histogram of forecast errors:
  points(myhist$mids, myhist$density, type="l", col="blue", lwd=2)
}

#ARIMA test 1 week data
library(forecast)
traveltime3 <- traveltime[1:1440,]
tstraveltime3 <- ts(traveltime3$calibratedtraveltime,frequency=12)
plot.ts(tstraveltime3)
plot.ts(tstraveltime3,ylab="Travel time",xlab="Time sequence (5-min)")
#tscom3 <- decompose(tstraveltime3)
#plot(tscom3)
#tssum <- ts(traveltimesum$averagetime,frequency=12)
#plot.ts(tssum)

#Auto ARIMA - original time series data
par(mfrow=c(1,2))
acf(tstraveltime3, main="ACF of travel time")  
pacf(tstraveltime3, main="PACF of travel time") 

#Differencing
traveltimediff3 <- diff(tstraveltime3, difference=1)
plot.ts(traveltimediff3, main="1st Differencing")
#Auto ARIMA - original time series data
acf(traveltimediff3, main="ACF of travel time")  
pacf(traveltimediff3, main="PACF of travel time")

tsmodel1 <- arima(tstraveltime3,order=c(1,1,0)) 
tsmodel1
#tsmodel1_fc <- forecast.Arima(tsmodel1,h=288)
#par(mfrow=c(1,1))
#plot.forecast(tsmodel1_fc)
par(mfrow=c(1,2))
plot.ts(tsmodel1$residuals)   
plotForecastErrors(tsmodel1$residuals)
acf(tsmodel1$residuals)
pacf(tsmodel1$residuals)
tsdiag(tsmodel1)
# prediction with new datasets
# Test model with a new dataset
#testSpeed<-loadData("d03_text_station_5min_2015_04_07",1) 
# Instantaneous  Travel Time in Minutes
#testInstantTTime<-MLStations$Length/testSpeed*60   
#testInstantaneurTTime<-colSums(testInstantTTime)
predarima<-forecast(tsmodel1,h=36)
#predarima2<-predict(tsmodel1,n.ahead=36)
fitarima<-fitted(tsmodel1)
testInstantaneurTTime<-traveltime[1:1440,3]

png(filename = paste("4-7 prediction.png",sep=""), width = 320, height = 250,units = "px", bg = "white",family = "", restoreConsole = TRUE)
par(mfrow=c(1,1)) 
par(mar=0.1+c(2.0,2.7,1.5,0.8),mgp=c(1.0,0.2,0.0),oma=c(0.0,0.0,0.0,0.3)) #Bottom, Left, Top, Right
plot(testInstantaneurTTime,type="l",col=1,lwd=2,tck=-0.01,ylim=c(30,45),xlab="Time Sequence (5-minute)",ylab="Travel Time (minute)",cex.lab=0.9,cex.axis=0.8) 
lines(1:1440,fitarima,col=2,lwd=2)

#pred<-predict(model1, data.frame(testExpTTime[1:281]), interval = "prediction")
#lines(2:282,pred[,1],col=4,lwd=2)
legend("topright",c("Observed","Fitted"),cex=0.8,col=c(1,2,4),lty=1)
#dev.off()

par(mfrow=c(1,2))
#Predict Future Travel time using trained model
#Predict April 3, 2015
traveltime4 <- traveltime[6913:7200,]
tstraveltime4 <- ts(traveltime4$calibratedtraveltime,frequency=12)
refit <- Arima(tstraveltime4, model=tsmodel1)
refit
fitarima<-fitted(refit)
plot.ts(refit$residuals)   
plotForecastErrors(refit$residuals)
acf(refit$residuals)
pacf(refit$residuals)
testInstantaneurTTime<-traveltime[6913:7199,3]
plot(testInstantaneurTTime,type="l",col=1,lwd=2,tck=-0.01,ylim=c(30,45),xlab="Time Sequence (5-minute) April 3, 2015",ylab="Travel Time (minute)",cex.lab=0.9,cex.axis=0.8) 
lines(2:288,fitarima[2:288],col=2,lwd=2)
legend("topright",c("Observed","Fitted"),cex=0.8,col=c(1,2,4),lty=1)
predarima<-forecast(tsmodel1,h=144)
#lines(289:432,predarima$mean,col=3,lwd=2)

#Predict April 2, 2015
traveltime4 <- traveltime[6625:6912,]
tstraveltime4 <- ts(traveltime4$calibratedtraveltime,frequency=12)
refit <- Arima(tstraveltime4, model=tsmodel1)
refit
fitarima<-fitted(refit)
plot.ts(refit$residuals)   
plotForecastErrors(refit$residuals)
acf(refit$residuals)
pacf(refit$residuals)
testInstantaneurTTime<-traveltime[6625:6911,3]
plot(testInstantaneurTTime,type="l",col=1,lwd=2,tck=-0.01,ylim=c(30,45),xlab="Time Sequence (5-minute) April 2, 2015",ylab="Travel Time (minute)",cex.lab=0.9,cex.axis=0.8) 
lines(2:288,fitarima[2:288],col=2,lwd=2)
legend("topright",c("Observed","Fitted"),cex=0.8,col=c(1,2,4),lty=1)
predarima<-forecast(refit,h=144)
lines(289:432,predarima$mean,col=3,lwd=2)
plot.forecast(predarima)

#Predict April 6, 2015 
traveltimeapr <- read.csv('traffic_cumulative_timeapr67.csv')

traveltime46 <- traveltimeapr[1:288,]
tstraveltime46 <- ts(traveltime46$calibratedtraveltime,frequency=12)
refit <- Arima(tstraveltime46, model=tsmodel1)
refit
fitarima<-fitted(refit)
plot.ts(refit$residuals)   
plotForecastErrors(refit$residuals)
acf(refit$residuals)
pacf(refit$residuals)
testInstantaneurTTime<-traveltimeapr[1:287,3]
plot(testInstantaneurTTime,type="l",col=1,lwd=2,tck=-0.01,ylim=c(30,45),xlab="Time Sequence (5-minute) April 6, 2015",ylab="Travel Time (minute)",cex.lab=0.9,cex.axis=0.8) 
lines(2:288,fitarima[2:288],col=2,lwd=2)
legend("topright",c("Observed","Fitted"),cex=0.8,col=c(1,2,4),lty=1)
predarima<-forecast(refit,h=144)
lines(289:432,predarima$mean,col=3,lwd=2)
plot.forecast(predarima)

#Predict April 7, 2015 
traveltime47 <- traveltimeapr[289:576,]
tstraveltime47 <- ts(traveltime47$calibratedtraveltime,frequency=12)
refit <- Arima(tstraveltime47, model=tsmodel1)
refit
fitarima<-fitted(refit)
plot.ts(refit$residuals)   
plotForecastErrors(refit$residuals)
acf(refit$residuals)
pacf(refit$residuals)
testInstantaneurTTime<-traveltimeapr[289:575,3]
plot(testInstantaneurTTime,type="l",col=1,lwd=2,tck=-0.01,ylim=c(30,50),xlab="Time Sequence (5-minute) April 7, 2015 ARIMA(1,1,0)",ylab="Travel Time (minute)",cex.lab=0.9,cex.axis=0.8) 
lines(2:288,fitarima[2:288],col=2,lwd=2)
legend("topright",c("Observed","Fitted"),cex=0.8,col=c(1,2,4),lty=1)
predarima<-forecast(refit,h=144)
lines(289:432,predarima$mean,col=3,lwd=2)
plot.forecast(predarima)



