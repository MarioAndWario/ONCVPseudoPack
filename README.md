# ONCVPseudoPack

## What are pseudopotentials?

The theory of pseudopotentials is based on the *Phillips-Kleinman cancellation theorem* [1]: the wavefunctions of the valence and higher-energy electronic states are expected to be smooth away from the atomic sites and oscillatory with atomic character in the core region, and it is possible to derive a pseudopotential that guarantees the orthogonality between the valence electronic states and the implicitly included core electronic states. This formalism justifies the intuition that only valence electrons participate in the chemical bonding, while core electrons are mostly inactive. 

Pseudopotentials eliminate the core electrons from the Kohn-Sham equation, remove the original strong electron-ion interaction, and therefore allow the use of simple basis sets (e.g., plane waves) for a numerical solution with nice convergence behavior. In general, the construction of first-principles pseudopotentials involves first solving the all-electron (AE) Kohn-Sham equation (including both core and valence states) for a given atom in a particular configuration. Given the AE wavefunctions, a set of pseudowavefunctions can be built by some standardized pseudization procedures (e.g., connection to AE wavefunctions beyond a radius, smoothness up to high-order derivatives, norm-conserving or not, parameterization, etc.). Pseudopotentials can then be constructed by inverting the Schrödinger equation using the AE eigenvalues of valence states and corresponding pseudowavefunctions. To ensure the transferability of pseudopotentials, it is important to "unscreen" them by removing the electronic contributions arising from Hartree and exchange-correlation potentials, because these components are specific to a particular configuration. The resulting potentials are called ionic pseudopotentials and they are widely used in first-principles calculations (DFT and beyond) for different physical properties in different chemical environments [2, 3].

## What is ONCVPSP?

ONCVPSP is short for **Optimized Norm-Conserving Vanderbilt Pseudopotential**, first proposed by Hamann in 2013 [4]. Norm-conserving (NC) pseudopotentials (PPs) were first proposed by Hamann, Schlüter and Chiang [5] and further generalized by Kleinman and Bylander [6]. The charge conservation property of norm-conserving pseudopotentials are expected to give greater transferability than that of the ultrasoft (US) and projector augmented wave (PAW) pseudopotentials. NC PPs are still important for hybrid density functionals, many-body perturbation theory (e.g., $GW$ , Bethe-Salpeter equation, etc.), and density-functional perturbation theory (DFPT) calculatons where the formalism is much simpler and reliable than that of US and PAW PPs. Traditionally, NC PPs requires a higher kinetic energy cutoff than that of US and PAW PPs, which makes the computation very costly. The introduction of ONCVPSP greatly reduces the energy cutoff of NC PPs while still keeping the same transferrability and accuracy.

Ref. [7] proposes a high-throughput optimization algorithm to build a ONCVPSP library ([SG15 dataset](http://www.quantum-simulation.org/potentials/sg15_oncv/)) for elements up to $Z=83$ (Bi) (excluding Lanthanides) by developing a quality function that measures the accuracy of the lattice constant of a PP calculation compared with a high accuracy AE one. The qualify function also penalize high energy cutoff. Ref. [8] uses the same strategy to test the quality of full relativistic PPs. Ref. [9] introduces the [PseudoDojo](http://www.pseudo-dojo.org) framework for developing and testing full tables of ONCVPSP PPs. It considers the effects of both the core-valence partitioning and the non-linear core corrections. According to Refs. [4,7-9], the lattice constants and bulk moduli from ONCVPSP calculations are similar to those from AE calculations, with a plane-wave energy cutoff slightly larger than that of USPPs.

## Introduction to ONCVPseudoPack

During my research, oftentime I need to find certain norm-conserving pseudopotentials with full-relativistic full-shell configurations (e.g., Cr including 3s, 3p semicore states) and soft energy cutoff for DFT and $GW$ calculations, so I have collected some of the most popular and reliable ONCVPSP libraries in this repository, namely, [SG15](http://www.quantum-simulation.org/potentials/sg15_oncv/) [9], [Abinit](https://www.abinit.org/psp-tables) [10], and [PseudoDojo](http://www.pseudo-dojo.org) [11]. In my research, I mostly use LDA and GGA-PBE (sometimes PBEsol) exchange-correlation functionals with or without full relativistic effects, and therefore I have written some automation shell scripts to generate  PPs from the standard input files. Below you can find some more details about this repository:

* Collection of ONCVPSP pseudopotentials (SG15 v1.2, Abinit v0.4, PseudoDojo FRv0.4 + SRv0.41).
* SG15 and Abinit ONCVPSP PP files (UPF format for Quantum ESPRESSO, psp8 format for Abinit,
  **FR** for full-relativistic, **SR** for scalar-relativistic) are generated with ONCVPSP v3.3.1 + libxc v3.0.1.
* I use input files of SG15 and Abinit ONCVPSP PPs to generate LDA, PBE, and PBEsol PPs with FR and SR treatment of spin-orbit coupling.
* PseudoDojo PPs are simply downloaded from their website.
* These PPs are good for $GW$ calculations where norm-conserving condition is required.
* You can customize the exchange-correlation functionals and ONCVPSP version in the foundary directory. The LDA, PBE, and PBEsol PPs are available in this repository. There are some missing PPs due to the failure of the generation process, but you can find alternatives in other PP libraries.
* Sometimes GGA+$U$ may crash. LDA+$U$ seems to be more stable.
* $GW$ calculations need PP with full-shell configuration, but some PPs in this repository may not meet this requirement. Double-check the valence electron configuration before doing a calculation.
* If you use SCAN exchange-correlation functionals in your DFT calculations with Quantum ESPRESSO, make sure that your PP does not include non-linear core corrections. SG15 PPs do NOT have non-linear core corrections, while Abinit and PseudoDojo PPs have non-linear core corrections.
* Use at your own risk! You should always double check your results carefully, especially the occurrance of ghost states.

## References

[1] J. C. Phillips and L. Kleinman, _Phys. Rev._ **116**, 287 (1959).

[2] M. L. Cohen, _Annu. Rev. Mater. Sci._ **14**, 119 (1984).

[3] R. M. Martin, Electronic Structure: Basic Theory and Practical Methods (Cambridge University Press, 2020).

[4] D. R. Hamann, _Phys. Rev. B_ **88**, 085117 (2013).

[5] D. R. Hamann, M. Schlüter, and C. Chiang, _Phys. Rev. Lett._, **43**, 1494 (1979).

[6] Kleinman and D. M. Bylander, _Phys. Rev. Lett._, **48**, 1425 (1982).

[7] M. Schlipf and F. Gygi, _Comput. Phys. Commun._ **196**, 36 (2015).

[8] P. Scherpelz, M. Govoni, I. Hamada, G. Galli, _J. Chem. Theory Comput._ **12**, 3523 (2016).

[9] M. J. van Setten, M. Giantomassi, E. Bousquet, M. J. Verstraete, D. R. Hamann, X. Gonze, and G.-M. Rignanese, _Comput. Phys. Commun_. **226**, 39 (2018).

[9] http://www.quantum-simulation.org/potentials/sg15_oncv/

[10] https://www.abinit.org/psp-tables

[11] http://www.pseudo-dojo.org

## Contact

Meng Wu

wu1meng2@berkeley.edu