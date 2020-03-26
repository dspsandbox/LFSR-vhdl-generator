# LFSR-vhdl-generator
This project is based on a simple Python library and a Vhdl template for the generation of arbitary LFSR based pipelined pseudorandom number generators [1]. The configurable parameters are:

* **LFSR length**: length in bits of the shift register
* **Tap list**: indices of shift register entries for the linear-feedback. We use indices 0,1,2,3,4,... which differ [2], that uses 1,2,3,4,5... Please keep in mind to adapt the indices accordingly. 
* **LFSR interations / clk cycle** : number of feedback steps per clock cycles. Defines the number of available pseudorandom bits per clock cycle. Has to be less or equal than LFSR length.

### Implementation example
Schematic for a single iteration on a 8 bit LFSR with tap list = [7, 5, 4, 3].
        
            ___   ___   ___   ___   ___   ___   ___
           |   | |   | |   | |   | |   | |   | |   | 
           v     v     v     v     v     v     v 
         |7|   |6|   |5|   |4|   |3|   |2|   |1|   |0| 
          |           |     |     |      ___        ^
          |           |     |     |_____|   |       |
          |           |     |___________|XOR|_______|
          |           |_________________|   |
          |_____________________________|___|

### Python
```python
import lfsr

# Parameters
lfsrLen=8
lfsrIter=8
tapList=[7,5,4,3]
templatePath="lfsr_template.vhd"
outputPath="lfsr_output.vhd"

# Code generation
generate_vhdl(lfsrLen,lfsrIter,tapList,templatePath,outputPath)
```

### Examples 
Idem LFSR register length and tap list but distinct iterations / clk cycle. The red area (see images bellow) highlights the equivalent shift registers.

* **Example (I):** */Examples/8Bit_1Iter/lfsr.vhd*
```python
lfsrLen=8
lfsrIter=1
tapList=[7,5,4,3]
```
![](/Examples/8Bit_1Iter/simulation.PNG)

* **Example (II):** */Examples/8Bit_8Iter/lfsr.vhd*
```python
lfsrLen=8
lfsrIter=8
tapList=[7,5,4,3]
```

![](/Examples/8Bit_8Iter/simulation.PNG)




### References
[1] [Wikipedia, basic LFSR concepts](https://en.wikipedia.org/wiki/Linear-feedback_shift_register)  
[2] [Xilinx Application Note](https://www.xilinx.com/support/documentation/application_notes/xapp052.pdf)
