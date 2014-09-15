

class Carte {
	char _proprietaire;
	int _couleur;
	int _valeur;
	Carte* _succ;
	/**
	 * \fn void _change(bool p = true)
	 * \brief Change the owner of the card
	 * Change te owner of the card if p is true
	 * \param[in] p
	 */
	void _change(bool p = true);
	/**
	 * \fn bool _equal(Carte carte)
	 * \brief Compare two cards
	 * Compare the value and the colour of the cards
	 * \return bool True if both cards are equal, or false
	 * 
	 */
	bool _equal(Carte carte);
public:
	static Carte* _debutN;
	static Carte* _finN;
	static Carte* _debutS;
	static Carte* _finS;
	/**
	* \fn Carte(int, int, char)
	* \brief Class Constructor
	*
	* \param[in] couleur Colour of the card
	* \param[in] valeur Value of the card
	* \param[in] proprietaire Owner of the card
	*/
	Carte(int couleur, int valeur, char proprietaire);
	/**
	 * \fn Carte() 
	 * \brief Default Constructor
	 */
	Carte();
	/**
	 * \fn void afficher()
	 * \brief Display the card
	 */
	void afficher();
	/**
	 * \fn static void afficherN()
	 * \brief Display the deck of N
	 */
	static void afficherN();
	/**
	 * \fn static void afficherS()
	 * \brief Display the deck of S
	 */
	static void afficherS();
	/**
	 * \fn static Carte* getNTete()
	 * \brief Get the first card of the deck N
	 * \return Carte* the first card of N
	 */
	static Carte* getNTete();
	/**
	 * \fn static Carte* getSTete()
	 * \brief Get the first card of the deck S
	 * \return Carte* the first card of S
	 */
	static Carte* getSTete();
	/**
	 * \fn bool egale(Carte carte)
	 * \brief Compare the value of two cards
	 * \param[in] carte The card to campare
	 * \return bool true if the cards are equal or false
	 */
	bool egale(Carte carte);
	/**
	 * \fn Carte* suc()
	 * \brief Return the successor of the card
	 * \return Carte* the successor or NULL
	 */
	Carte* suc();
	/**
	 * \fn void changerProp()
	 * \brief Change the owner of the card
	 * Call the method _change
	 */
	void changerProp();
	/**
	 * \fn supAbs(Carte carte)
	 * \brief Compare two cards
	 * \param[in] carte The card to campare
	 * \return bool True if the value of the object is higher than the value of carte or false
	 */
	bool supAbs(Carte carte);
	/**
	 * \fn void passerDerriere()
	 * \brief Put the card in the end of the deck
	 * Call to the method _change
	 */
	void passerDerriere();
};



enum Couleur{PIQUE = 1, TREFLE, COEUR, CARREAU};
enum Valeur{AS = 1, DEUX, TROIS, QUATRE, CINQ, SIX, SEPT, HUIT, NEUF, DIX, VALET, DAME, ROI};
