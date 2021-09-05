# ONCVPseudoPack

## Introduction

* Collection of ONCVPSP pseudopotentials (SG15 v1.2, Abinit v0.4, PseudoDojo FRv0.4 + SRv0.41).
* SG15 and Abinit ONCVPSP pseudopotential(PP) files (UPF format for Quantum ESPRESSO, psp8 format for Abinit,
  FR for full-relativistic, SR for scalar-relativistic) are generated with ONCVPSP v3.3.1 + libxc v3.0.1.
* I use input files of SG15 and Abinit ONCVPSP PPs to generate LDA, PBE, and PBEsol PPs with FR and SR treatment of
  spin-orbit coupling.
* PseudoDojo PPs are simply downloaded from their website.
* These PPs are good for GW calculations where norm-conserving condition is required.
* You can customize the exchange-correlation functionals and ONCVPSP version in the foundary directory.

## References

* D. R. Hamann, Phys. Rev. B 88, 085117 (2013).
* M. Schlipf and F. Gygi, Comput. Phys. Commun. 196, 36 (2015).
* P. Scherpelz, M. Govoni, I. Hamada, G. Galli, J. Chem. Theory Comput. 12, 3523 (2016).
* http://www.quantum-simulation.org/potentials/sg15_oncv/
* https://www.abinit.org/psp-tables
* http://www.pseudo-dojo.org

## Contact

Meng Wu, wu1meng2@berkeley.edu