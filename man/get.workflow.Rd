% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get.workflow.R
\name{get.workflow}
\alias{get.workflow}
\title{Get the details of a particular PEcAn workflow using the workflow ID}
\usage{
get.workflow(server, workflow_id)
}
\arguments{
\item{server}{Server object obtained using the connect() function}

\item{workflow_id}{ID of the PEcAn workflow whose details are needed}
}
\value{
Response obtained from the \verb{/api/workflow/\{id\}} endpoint
}
\description{
Obtain the details of a particular PEcAn workflow by supplying
its ID. Hits the \verb{/api/workflows/\{id\}} API endpoint
}
\examples{
server <- connect(url="http://pecan.localhost:80", username="carya", password="illinois")

# Get details of workflow with id = '1000009172'
res <- get.workflow(server, workflow_id=1000009172)
}
\author{
Tezan Sahu
}
