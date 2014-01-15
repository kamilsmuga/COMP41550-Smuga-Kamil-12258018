- Name: HelloUCD
- Kamil Smuga
- Student Number: 12258018
- email: smugakamil@gmail.com
- comments:

1. Things done to display logo and label properly on iPhones 4 and 5:
- A view in Main.storyboard contains a Container View. Container View is
  center aligned to X and Y to a Superview. Also, a Container View has fixed Height
  and Width constraints.
- A Label inside Container has 2 Constraints: fixed Verical Space to Top Layout Guide and Center X alignment
- An Image inside Container has fixed Width and Height and is Centerer to X and
  Y
Moreover, for Label and Image Instrinsic Size has been set up to Placeholder.

Due to the fact that each view's position and size is defined by three values:
leading space, size and trailing space, for each element defined at least 2 constraints. That allows third one to be calculated and clear XCode Issues.
