#Installer les packages nécessaires
packages <- c("shiny", "mongolite", "ggplot2")


#On vérifie si les packages sont déjà installés
install_packages <- packages[!packages %in% installed.packages()]
if (length(install_packages) > 0) {
  install.packages(install_packages)
}