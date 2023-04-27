############## Weighted average trophic level by biomass ##################
weight_trophic_biomass_unfished <- function(model,network_indices,hr_length){
  weighted_trophic <- vector(mode = "list",hr_length^2)  #initialise weighted trophic storage
  
    biomass_strip <- model$final.year.outputs$mass_results_wholedomain[,1]
    trophic_levels <- network_indices[1:33,] #initialise trophic levels array & biomass array, pair each value
    biomass_levels <- c(biomass_strip[32],biomass_strip[33],biomass_strip[8],biomass_strip[10],biomass_strip[34],biomass_strip[35],
                        biomass_strip[11],biomass_strip[13],biomass_strip[36],biomass_strip[1],biomass_strip[4],biomass_strip[3],biomass_strip[7],
                        biomass_strip[6],biomass_strip[5],biomass_strip[14],biomass_strip[37],biomass_strip[15]+biomass_strip[16],biomass_strip[17],
                        biomass_strip[18],biomass_strip[23],biomass_strip[26],biomass_strip[24],biomass_strip[25],biomass_strip[27],biomass_strip[19],
                        biomass_strip[21],biomass_strip[20],biomass_strip[22],biomass_strip[28],biomass_strip[29],biomass_strip[30],biomass_strip[31])
    
    #compute weighted averages
    weighted_trophic_sums <- sum(biomass_levels * trophic_levels) / sum(biomass_levels)
    weighted_trophic = weighted_trophic_sums
    #cleanup
    rm(biomass_strip,trophic_levels,biomass_levels,weighted_trophic_sums)


  return(weighted_trophic)
}
###########################################################################



