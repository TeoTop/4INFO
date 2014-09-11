

class Carte {
	char _proprietaire;
	int _couleur;
	int _valeur;
	Carte* _succ;
	void _change(bool = true);
	bool _equal(Carte);
public:
	static Carte* _debutN;
	static Carte* _finN;
	static Carte* _debutS;
	static Carte* _finS;
	/* *
	* \fn 
	* \brief 
	*
	* 
	*
	* \param [in]
	* \param [out]
	* \param [in,out]
	*
	* \return Carte
	*/
	Carte(int, int, char);
	Carte();
	void afficher();
	static void afficherN();
	static void afficherS();
	static Carte* getNTete();
	static Carte* getSTete();
	bool egale(Carte);
	Carte* suc();
	void changerProp();
	bool supAbs(Carte);
	void passerDerriere();
	//typedef enum { PIQUE = 1, TREFLE, COEUR, CARREAU } Couleur;
};



enum Couleur{PIQUE = 1, TREFLE, COEUR, CARREAU};
enum Valeur{AS = 1, DEUX, TROIS, QUATRE, CINQ, SIX, SEPT, HUIT, NEUF, DIX, VALET, DAME, ROI};
