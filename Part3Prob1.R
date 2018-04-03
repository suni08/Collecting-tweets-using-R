#Load package twitteR
library(twitteR)
library(RJSONIO)

#Auntheticate to twitter
setup_twitter_oauth('WjuFA059lXmCZYsJ1WtxFJgfV', '5ZhilwV2xZGporeQR9OGvOx6VPS0XtvXa14UlR8etLrlelqnJr', '961110803847045120-t6UKzXnJ7etfJ7DFXVMfe357bgnGUhX', 'vpscyyykNYsKB5kpH64mFonhXYNp2UR8weLerjzGkev3o')

#search for tweets
searchTerm <- "flu+influenza"
searchResults <- searchTwitter(searchTerm, n = 20000, geocode='39.8283,-98.5795,1200mi')

#Convert search result tweets into dataframe
tweetFrame <- twListToDF(searchResults)
#write.csv(tweetFrame,'searchedtweets_final.csv')

#Lookup screen names from this dataframe
userInfo <- lookupUsers(tweetFrame$screenName)  

#Convert these screen names into another dataframe
userFrame <- twListToDF(userInfo)  
#write.csv(userFrame,'userframe.csv')

#Convert null values of location to NA
userFrame$loc <- ifelse(userFrame$location=="",NA,userFrame$location)

#Keep only users (user names) with location info
locatedUsers <- !is.na(userFrame$loc) 
#print(locatedUsers)
#print(userFrame$location[locatedUsers])

#Get the geocode of the locations from this dataframe
library(ggmap)
loc <- iconv(userFrame$loc[locatedUsers], "ASCII", "UTF-8", sub="")
#write.csv(loc,'userLocations.csv')

locations <- geocode(loc,messaging = FALSE,source = "google")
#write.csv(locations,'userLocationsLatLong.csv')

# Rename the column lon to long
colnames(locations)[colnames(locations)=="lon"] <- "long"

#Remove locations with NA
library(plyr)
sim2 <- locations[!is.na(locations$long),]

#Convert long,lat to numeric value
sim2$long <- as.numeric(sim2$long)
sim2$lat <- as.numeric(sim2$lat)

#find regions from long,lat for the whole column
library(ggmap)
#result <- do.call(rbind,lapply(1:nrow(sim2),function(i)revgeocode(as.numeric(sim2[i,1:2]))))
result <- do.call(rbind,lapply(1:nrow(sim2),function(i)as.character(factor(revgeocode(as.numeric(sim2[i,1:2]),output="more",messaging = FALSE)$administrative_area_level_1))))

#find frequency of regions to know frequency of tweets
sim1 <- count(result)

# Rename a column to region and change all to lowercase
colnames(sim1)[colnames(sim1)=="x"] <- "region"
sim1$region <- tolower(sim1$region)

#Merge data from out dataframe to state map for plotting heat map
sim <- merge(state, sim1,sort=FALSE, by="region",all.x=T)
sim <- sim[order(sim$order), ]

sim$freq1 <- ifelse(is.na(sim$freq),"0",sim$freq)
#write.csv(sim,'finallocheatmap.csv')

#Finally plotting the heatmap acc to frequency obtained
#print(qplot(long,lat, data=sim, geom="polygon", fill=as.numeric(sim$freq1), group=group))
my_palette <- colorRampPalette(c("red", "yellow", "green"))(n = 51)

print(ggplot(sim, aes(x=long,y=lat,group=group))+
        geom_polygon(aes(fill=as.numeric(sim$freq1)))+
        geom_path()+ 
        scale_fill_gradientn(colours=my_palette,na.value="transparent",name="Frequency Level") +
        ggtitle("Tweets Frequency about Influenza or Flu in USA"))

