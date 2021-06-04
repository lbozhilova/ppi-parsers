##########################
##### BioGRID parser #####
##########################

# Parse BioGRID tab3 files

# Last edited: 04/06/21 by LVB

#--- Packages
require("tidyverse")

#--- BioGRID parser
# TODO: Edit the "tidy up column" section - currently designed
# to output publication source only.
parse_biogrid <- function(filename,
                          interspecies = FALSE,
                          loops = FALSE,
                          experimental_system = NULL,
                          experimental_system_type = NULL,
                          throughput = NULL){
  df <- read_tsv(filename,
                 col_names = T,
                 col_types = "ccccccccccccccccccccccccccccccccccccc",
                 na = "-")
  # Remove missing interactors
  df <- subset(df, !(is.na(`Entrez Gene Interactor A`) | is.na(`Entrez Gene Interactor B`))) 
  # Filter according to other conditions
  if (!interspecies)
    df <- subset(df, `Organism ID Interactor A` == `Organism ID Interactor B`)
  if (!loops)
    df <- subset(df, `Entrez Gene Interactor A` != `Entrez Gene Interactor B`)
  if (!is.null(experimental_system))
    df <- subset(df, `Experimental System` %in% experimental_system)
  if (!is.null(experimental_system_type))
    df <- subset(df, `Experimental System Type` %in% experimental_system_type)
  if (!is.null(throughput))
    df <- subset(df, `Throughput` %in% throughput)
  # Tidy up columns
  df <- df[,c(2:3, 15)]
  colnames(df) <- c("int1", "int2", "pub")
  df
}
