# <img src="./Images/LogoCRT_3D_Klein.png" width="100" /> Chemical Reactor Design Toolbox

## Introduction and Motivation

A fundamental knowledge and a basic understanding of the interactions
between chemical reactions and various transport processes is
essential for a proper design of chemical reactors and related
processes. However, presenting those fundamentals in the classroom has
been difficult to motivate students to rise to the
challenges. Therefore, the Chemical Reactor Design Toolbox was
developed to provide a tool to address the challenge through an
innovative, creative and playful approach.

The toolbox is implemented as a new custom library for the
MATLAB® /Simscape framework consisting of basic blocks. Each block
represents either a balancing control volume, a physical transport
process (for mass, heat and momentum), a source/sink due to a chemical
reaction or a thermodynamic phase equilibrium. A multicomponent
mixture of an arbitrary number of individual species is considered in
each phase (gas, solid, liquid and interface). By combining several
basic blocks into subsystems composite blocks can be defined.
Iteratively applied, hierarchical multi-scale models can be created
from scratch without the need of writing a single line of code
(no-code programming).

The toolbox has been successfully applied in chemical engineering,
biochemical reaction engineering, and electrochemical reaction
engineering courses. In addition, digital twins of actual experimental
setups have been created to provide a quasi hands-on experience for
the students to train their experimental skills without the need of
placing expensive laboratory equipment at their disposal.

## Fundamentals

 siehe: /home/klaus/OOChemReactorDesign/Doc/Diverses/Webinar.org und talk.org sowie Beamer.org
 



The library design is based on three fundamental paradigms:
- Control Volume Approach
- Object-Oriented Modelling
- Hierarchical Systems

Maybe, the first paradigm looks very familiar to you. Actually, this
is very basic to every engineering student, because it addresses the
way engineers are going to set up balance equations of all kinds. The
very starting point for every balance equation is a formulation by
words. Since we are addressing chemical reactive systems, the balance
equation shown below is formulated in terms of the number of moles
$n_i$ for a single species $A_i$.

<img src="./Images/bilanz.svg">

The graphical representation of the equation is given below.

<img src="./Images/control_volume_approach.svg">

A volume of finite size is considered named $\Delta V$.  Only the
one-dimensional case is sketched here for reasons of simplicity. The
molar flux of species $A_i$ is termed $N_{i}$. Multiplied with the
respective cross-sectional area the molar flow rate $F_i$ into the
control volume is obtained. The same holds for the outflow molar flow
rate.

In the case shown the reaction rate is formulated with respect to the
volume, it is a volume-based source term. The respective molar flow
rate due to the chemical reaction can thus be obtained by multiplying
the production rate $R_i$ of $A_i$ with the size of the control
volume. Then the balance equation becomes.








Das ist die Argumentation. Ich habe oben die Bilanzgleichung stehen
und postuliere jetzt einen alternativen graphischen Aufbau. Aus dem
Kirchhoffschen Gesetz resultiert die Analogie.

Zudem sollte ich erwähnen, dass in dem Joint die Gleichheit der
Zustandsgrößen gilt. Auch das ist wesentlich, da das ja für das
Kontrollvolumen elementarer Bestandteil ist.

[[file:../Pics/joint.png]]

Conservation of the quantity
Kirchhoff's Law

$$0 = -\frac{dn_{i}}{dt} + F_{i}^{in} - F_{i}^{out} + F_{i}^{R}$$

The rate of accumulation can be regarded as a virtual molar flow
rate in or out of the control volume. Thus by introducing a
virtual node the equation is graphically represented.

According to Kirchhoff's circuit law at the node the sum of all
flow rates entering or leaving the node must be zero.

This leads us directly to the general design rule:
- Every transport block must be at least connected to a volume block
  on either side. Never ever connect two transport blocks to each
  other without adding a volume block.
- Moreover, never ever connect two balance blocks together without any
  further transport block. Ignoring this rule will cause errors
  running the model. You have to take care of that!

[[file:../Pics/beamer9.png]]

** Balance Block

[[file:../Pics/balance_block.png]]

Balance Equation

$$\frac{d {\bf n}}{\partial t} = {\bf F}$$

** Transport Block

[[file:../Pics/transport_block.png]]

Transport Equation

$${\bf F} = A \, {\bf N} \big(\text{driving force}\big)$$


- _Instationäre Bilanzgleichung_
  \begin{equation}
  \label{eq:1}
  \frac{\partial {\bf n}}{\partial t} =
  \sum_{k} {\bf F}_{0}(k) - \sum_{k} {\bf F}(k)
  \end{equation}
  mit
  - \({\bf F}_{0}\) als dem Vektor der Eingangstoffströme und
  - \({\bf F}\) als dem Vektor der Ausgangsstoffströme

- Da in \verb+simscape+ die Verknüpfungen grundsätzlich
  _bidirektional_ sind, besitzt jedes Kontrollvolumen nur einen
  _einzigen_ Port mit vektoriellen Stoffströmen $\vec{\bf
  F}(k)$. Damit entfällt die Unterscheidung zwischen Ein- und
  Ausgangsstoffströmen. 

### Volumen

*Hinweis* Ein solches Bilanzvolumen definiert _keine_ Stoffströme.

Instationäre Bilanzgleichung

$$ \frac{\partial {\bf n}}{\partial t} =
\sum_{k} {\bf F}_{0}(k) - \sum_{k} {\bf F}(k) $$
	
mit
  - ${\bf F}_{0}$ als dem Vektor der Eingangstoffströme und
	  - ${\bf F}$ als dem Vektor der Ausgangsstoffströme
  
			Da in \verb+simscape+ die Verknüpfungen grundsätzlich
  _bidirektional_ sind, besitzt jedes Kontrollvolumen nur einen
  _einzigen_ Port mit vektoriellen Stoffströmen $\vec{\bf
  F}(k)$. Damit entfällt die Unterscheidung zwischen Ein- und
  Ausgangsstoffströmen. 

  Die Summation über alle Stoffströme wird durch direkte Verknüpfung
  der Ports in einem Knoten realisiert. Analog der /Kirchhoffschen
  Regel/ gilt dabei für den Knotenpunkt

  $$0 = \sum\limits_{k} \vec{\bf F}(k)$$

  Damit ergibt sich z.B. der Eingangsstrom für ein Bilanzvolumen aus
  der Summation der drei im Knoten zusammenlaufenden Einzelströme

	<img src="./Images/ports.svg">

- Damit folgt für die Bilanzgleichung
  $$V \, \frac{\partial {\bf c}}{\partial t} = \sum_{k} \vec{{\bf F}}(k) = \vec{\bf F}$$

	<img src="./Images/volume.svg">

  Das als Parameter definierte entsprechende Volumen wird über einen
  physikalischen Port anderen Modulen zur Verfügung gestellt.

### Quellen/Senken

- Volumenquellen oder - senken werden mit der Kenntnis des
  entsprechenden Volumens als Stoffströme definiert.
  \begin{equation}
  \label{eq:3}
  {\bf F} = \Delta V \, {\bf R}\big({\bf c}\big)
  \end{equation}

  <img src="./Images/volsource.svg"/>

### Transportprozesse

- Transportprozesse werden mit der Kenntnis der für den
  Transportprozess zur Verfügung stehenden Fläche als _Flächenquellen_
  realisiert. Damit folgt für die resultierenden Stoffströme

$${\bf F} = A \, {\bf N}\big(\text{treibende Kraft}\big)$$

  Die dafür notwendige Austauschfläche wird dem Modul entweder als
  interner _Parameter_ oder über einen _physikalischen Port_ dem Modul
  zur Verfügung gestellt.

- Die treibenden Kräfte sind überwiegend Gradienten der Zustandsgrößen
 $\big({\bf c},T,p,\cdots)$.  Das hat zur Folge, dass ein solches
  Modul über zwei Ports A und B verfügt,

<img src="./Images/transport.svg"/>

  - Der Gradient wird dabei approximiert nach
  
$$\nabla {\bf c} \approx \frac{{\bf c}(B)-{\bf c}(A)}{\Delta z}$$

Die für den Bereich \(0 \leq z \leq \Delta z\) zutreffenden
Werte der Zustandsgrößen \(\bar{\bf c}\) lassen sich erhalten
nach
	- arithmetischer Mittelwert
   $$\bar{\bf c} = \frac{{\bf c}(A)+{\bf c}(B)}{2}$$
	oder
- Upstream
  $$\bar{\bf c} = \left\{
  \begin{array}{ccl}
  {\bf c}(A) & \text{für} & \sum {\bf F}>0 \\
  {\bf c}(B) & \text{für} & \sum {\bf F} \leq 0
  \end{array}
  \right.$$
	
Ein individuelles Upstream-Verfahren erscheint wenig
zielführend, da die Konzentrationen meist zur Berechnung der
Molanteile verwendet werden. Die in einem solchen Fall
resultierenden Werte sind bei Stoffströmen mit unterschiedlichen
Vorzeichen aber dann fragwürdig.

