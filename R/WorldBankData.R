#' A Global Threatened Birds and development Mapping Function
#'
#' This function allows you to visualize global threatened birds and development
#' @param Yes Do you want to map gdp and birds? Defaults to TRUE.
#' @keywords gdp
#' @export
#' @examples
#' WorldBankData_function()

WorldBankData_function <- function(ans=TRUE){
  if(ans==TRUE){

    library(WDI)
    library(ggplot2)
    library(googleVis)
    library(plyr)
    
    # World population total
    population = WDI(indicator='SP.POP.TOTL', country="all",start=2015, end=2016)
    # GDP in US $
    gdp= WDI(indicator='NY.GDP.MKTP.CD', country="all",start=2015, end=2016)
    # Endangered birds count
    ENBird= WDI(indicator='EN.BIR.THRD.NO', country="all",start=2015, end=2016)
    
    names(population)[3]="Total population"
    names(gdp)[3]="GDP (US$)"
    names(ENBird)[3]="Endangered Birds Species"
    
    
    j1 <- join(population, gdp)
    wbData <- join(j1,ENBird)
    
    #This returns  list of 2 matrixes
    wdi_data =WDI_data
    # The 1st matrix is the list is the set of all World Bank Indicators
    indicators=wdi_data[[1]]
    # The 2nd  matrix gives the set of countries and regions
    countries=wdi_data[[2]]
    df = as.data.frame(countries)
    aa <- df$region != "Aggregates"
    # Remove the aggregates
    countries_df <- df[aa,]
    # Subset from the development data only those corresponding to the countries
    bb = subset(wbData, country %in% countries_df$country)
    cc = join(bb,countries_df)
    dd = complete.cases(cc)
    developmentDF = cc[dd,]
    
    
    
    G <- gvisGeoChart(cc, locationvar="country", colorvar="income",
                      options=list(width=800, height=800))
    
    T <- gvisTable(cc,
                   options=list(width=800, height=800))
    
    GT <- gvisMerge(G,T, horizontal=TRUE)
    plot(GT)
  }
  else {
    print("Restart.")
  }
}

