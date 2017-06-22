# Yasumi Introduction

![](/docs/assets/wood-yasumi.png)

This section is provided in order to give some background information on how the initial program started. As this program is combining high processing requirements \(calculations\) in a recursive pattern, we thought it was a good candidate to look at the possible scaling options.

## The Puzzle

The Yasumi Puzzle \(or pentomino\) is a game in which different kinds of blocks have to be placed on a grid. Each block is made up of 5 cells each and there are 12 blocks in total. This is exactly the number of unique blocks that can be made up of 5 cells. In the original game these blocks have to be placed on a grid of 6 by 10. Blocks may be rotated if necessary.

The picture below shows you all the possible blocks of the puzzle:

![](/assets/yasumiBlocks.png)

The picture below shows you one of the solutions:

![](/assets/yasumiSolution.png)

## Help on the Internet

When looking at the initial challenge, I found a nice web-page created by [Jan Sipke van der Veen](https://jansipke.nl/yasumi-puzzle/) that provided a lot of feedback on the Puzzle and its challenges. He also provided me with the C code that solved the puzzle \(back in the days of the good old PentiumIII computers\) and I took it upon me to try and rebuild the solution in Java \(as my C knowledge was at a bare minimum\).

## Complexity

The following is taken from Jan Sipke's webpage:

> I wanted to have all solutions to this game and wrote a computer program to find them. Using brute force alone would not have gotten me very far, because the problem is very complex.
>
> For example, each block \(except the red one\) can be rotated. The red block cannot be rotated, so there is only one way to place it. The green block can be rotated once, so there are two ways to place it. Five other blocks can be rotated twice, so there are four ways to place them. The last five blocks can be rotated three times, so there are eight ways to place them. Therefore, counting rotations only, there are 67,108,864$$1^1*2^1*4^5* 8^5 = 
> 67,108,864 $$ ways to place the blocks.

This vast number of possible block placements is resulting in a possible **9356** real solutions of the puzzle.

## Optimization

In order to reduce the number of block placements, Jan Sipke implemented the following:

> I used backtracking to crack the problem. The function that checks the feasability of the partial solution is crucial to the success of the program. The function I came up with checks whether the size of the open areas in the grid are divisable by 5. If not, then blocks made up of 5 cells cannot be used to fill the open areas. At that point the partial solution can be ignored and another one can be constructed. The program took about 80 minutes on a Pentium II 366 MHz to compile a list of all solutions.

When looking at the provided optimization and solution, I added my own \(very small\) idea. Looking at all the blocks, the Cross shape is the only non-mutable form. Furthermore, given the fact that all blocks need to be on the grid, we can optimize our program by only calculating the solutions for the Cross as a starter and placing it only in the first Quadrant of the rectangle. Once a solution is found, we can then mirror it horizontal, vertical and diagonal to complete the full solution list.

Applying this last technique brought the solution time of my Java program to under 20 minutes as I only have to calculate 1/4th of the possible solutions.

![](/assets/mirrorSolutions.png)

