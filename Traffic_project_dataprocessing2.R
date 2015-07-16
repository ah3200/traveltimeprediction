Rawdata1<-read.table("./Downloads/d03_text_station_5min_2015_04_06.txt.gz",header=FALSE,sep=",")
Rawdata2<-read.table("./Downloads/d03_text_station_5min_2015_04_07.txt.gz",header=FALSE,sep=",")
Rawdata3<-read.table("./Downloads/d03_text_station_5min_2015_04_08.txt.gz",header=FALSE,sep=",")

Stationid=c(314485,314433,314419,313438,313450,313493,313512,318612,316438,316451,318816,318773,318788,317157,317166,316206,316222,316231,316252,316264)

sub1<-subset(Rawdata1, Rawdata1$V2 %in% Stationid)
sub2<-subset(Rawdata2, Rawdata2$V2 %in% Stationid)
sub3<-subset(Rawdata3, Rawdata3$V2 %in% Stationid)

main<-rbind(sub1,sub2,sub3)
pems_traffic_data<-main
#write.csv(main,file="pems_traffic_data.csv",sep=",",row.names=FALSE)

#Assign section id based on Station ID
pems_traffic_data$section[pems_traffic_data$V2 == 314485] <- 20
pems_traffic_data$section[pems_traffic_data$V2 == 314433] <- 19
pems_traffic_data$section[pems_traffic_data$V2 == 314419] <- 18
pems_traffic_data$section[pems_traffic_data$V2 == 313438] <- 17
pems_traffic_data$section[pems_traffic_data$V2 == 313450] <- 16
pems_traffic_data$section[pems_traffic_data$V2 == 313493] <- 15
pems_traffic_data$section[pems_traffic_data$V2 == 313512] <- 14
pems_traffic_data$section[pems_traffic_data$V2 == 318612] <- 13
pems_traffic_data$section[pems_traffic_data$V2 == 316438] <- 12
pems_traffic_data$section[pems_traffic_data$V2 == 316451] <- 11
pems_traffic_data$section[pems_traffic_data$V2 == 318816] <- 10
pems_traffic_data$section[pems_traffic_data$V2 == 318773] <- 9
pems_traffic_data$section[pems_traffic_data$V2 == 318788] <- 8
pems_traffic_data$section[pems_traffic_data$V2 == 317157] <- 7
pems_traffic_data$section[pems_traffic_data$V2 == 317166] <- 6
pems_traffic_data$section[pems_traffic_data$V2 == 316206] <- 5
pems_traffic_data$section[pems_traffic_data$V2 == 316222] <- 4
pems_traffic_data$section[pems_traffic_data$V2 == 316231] <- 3
pems_traffic_data$section[pems_traffic_data$V2 == 316252] <- 2
pems_traffic_data$section[pems_traffic_data$V2 == 316264] <- 1

pems_traffic_data$seclen[pems_traffic_data$V2 == 314485] <- 0.15
pems_traffic_data$seclen[pems_traffic_data$V2 == 314433] <- 1.807
pems_traffic_data$seclen[pems_traffic_data$V2 == 314419] <- 0.194
pems_traffic_data$seclen[pems_traffic_data$V2 == 313438] <- 1.999
pems_traffic_data$seclen[pems_traffic_data$V2 == 313450] <- 0.2
pems_traffic_data$seclen[pems_traffic_data$V2 == 313493] <- 1.5
pems_traffic_data$seclen[pems_traffic_data$V2 == 313512] <- 0.2
pems_traffic_data$seclen[pems_traffic_data$V2 == 318612] <- 0.271
pems_traffic_data$seclen[pems_traffic_data$V2 == 316438] <- 1.184
pems_traffic_data$seclen[pems_traffic_data$V2 == 316451] <- 0.182
pems_traffic_data$seclen[pems_traffic_data$V2 == 318816] <- 0.88
pems_traffic_data$seclen[pems_traffic_data$V2 == 318773] <- 0.439
pems_traffic_data$seclen[pems_traffic_data$V2 == 318788] <- 0.264
pems_traffic_data$seclen[pems_traffic_data$V2 == 317157] <- 3.654
pems_traffic_data$seclen[pems_traffic_data$V2 == 317166] <- 0.366
pems_traffic_data$seclen[pems_traffic_data$V2 == 316206] <- 8.02
pems_traffic_data$seclen[pems_traffic_data$V2 == 316222] <- 3.74
pems_traffic_data$seclen[pems_traffic_data$V2 == 316231] <- 2.18
pems_traffic_data$seclen[pems_traffic_data$V2 == 316252] <- 4.549
pems_traffic_data$seclen[pems_traffic_data$V2 == 316264] <- 6.977

pems_traffic_data$traveltime <- (pems_traffic_data$seclen*60)/pems_traffic_data$V12
write.csv(pems_traffic_data,file="pems_traffic_data_apr67.csv",sep=",",row.names=FALSE)
