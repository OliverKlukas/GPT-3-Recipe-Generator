String exampleText = """
1/2 cup Dijon mustard
1/4 cup honey
1/4 cup chopped fresh parsley
1/4 cup chopped fresh dill
1/4 cup chopped fresh chives
2 tablespoons chopped fresh tarragon
1 tablespoon chopped fresh thyme
1 tablespoon chopped fresh rosemary
1 tablespoon chopped fresh oregano
1 tablespoon chopped fresh basil
1 teaspoon salt
1 teaspoon freshly ground black pepper
4 (6-ounce) salmon fillets, skinned and boned
Directions:
Preheat the broiler. In a small bowl, whisk together the mustard, honey, parsley, dill, chives, tarragon, thyme, rosemary, oregano and basil. Season with salt and pepper. Place the salmon fillets on a broiler pan coated with cooking spray. Broil 4 inches from the heat for 5 minutes. Turn the salmon over and brush with the mustard mixture. Broil for 5 minutes or until the fish flakes easily when tested with a fork. Serve immediately.
""";


parseIngredientsAndDirections(String text) {
  List<String> result = text.split("Directions:\n");
  return result;
}