---
title: "Securities Dashboard"
author: "Venkatesh Avula"
output: 
  flexdashboard::flex_dashboard:
    source_code: embed
---

```{r setup, include=FALSE}
library(flexdashboard)
library(dygraphs)
library(TTR)
library(zoo)
library(quantmod)
library(dplyr)
library(lubridate)
```

```{r message=FALSE, warning=FALSE}
tickers <- c("AAPL", "MSFT", "TWTR")
invisible(getSymbols(tickers,from=ymd("2016-01-01")))
orgs <- list(AAPL,MSFT,TWTR)
plots <- list()

for (i in 1:3) {
y <-orgs[[i]][,-5]
colnames(y)<-c("Open","High","Low","Close","Adjusted")
p<-list(dygraph(y, main = tickers[i],ylab = "Price(USD)") %>%
  dyOptions(axisLineWidth = 1.5,  colors = RColorBrewer::brewer.pal(5, "Set1")) %>%
  dyLegend(show = "always",width = 500, hideOnMouseOut = TRUE) %>%
  dyCandlestick())
plots<-append(plots,p)
}
```

Column {data-height=500 .tabset .tabset-fade}
-----------------------------------------------------------------------
###<b>Apple</b>
```{r}
plots[[1]]
```

###<b>Microsoft</b>
```{r}
plots[[2]]
```

###<b>Twitter</b>
```{r}
plots[[3]]
```

```{r message=FALSE, warning=FALSE}
dateWindow<-c("2016-01-01", "2018-10-01")

nbrs <- function(y){do.call(merge, lapply(tickers, function(x) y(get(x))))}
measures <- list(Op,Cl,Vo)
plots<- list()
title<-c("Open Price (in USD)","Close Price (in USD)","Volume")

for (i in 1:3) {
p<-list(dygraph(nbrs(measures[[i]]), group="Stock",ylab =title[i]) %>%
  dyOptions(axisLineWidth = 2,  colors = RColorBrewer::brewer.pal(3, "Set2")) %>%
  dyOptions(stackedGraph = TRUE)%>%
  dyLegend(show = "always",width = 500, hideOnMouseOut = TRUE)
  )
plots <-append(plots,p)
}
```

Column {data-width=500}
-----------------------------------------------------------------------
###<b>Open Price</b>
```{r}
plots[[1]]
```

###<b>Close Price</b>
```{r}
plots[[2]]
```

###<b>Volume</b>
```{r}
plots[[3]]
```

