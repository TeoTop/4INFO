/*
 * fault_handler.c
 *
 *  Created on: 1 nov. 2008
 *      Author: lescouarnecn
 */
#include "mmu.h"
#include "physical_memory.h"
#include "swap.h"
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <assert.h>
#include <time.h>

// Page fault handler
//     Free one page if needed
//     Get free page
//     Load
//     Update MMU

enum state_page {SWAPPED, ALLOCATED, NOTMAPPED};

#define PRECLEAN

struct page_table_entry{
	enum state_page status;
	page_phys pp;
};

// Page table
struct page_table_entry* page_table;
int page_table_size;

// List of allocated pages
page_virt* allocated_pages;
int allocated_pages_capacity;
int allocated_pages_size;
// première page dans FIFO, dernière page utilisée dans CLOCK
int allocated_pages_first;




void init_faultHandler(int nb_pages_virt, int nb_pages_phys){
	int i;
	srand(time(NULL));
	page_table=(struct page_table_entry*)malloc(sizeof(struct page_table_entry)*nb_pages_virt);
	page_table_size=nb_pages_virt;
	for(i=0;i<nb_pages_virt;i++){
		page_table[i].pp=INVALID;
		page_table[i].status=NOTMAPPED;
	}

	allocated_pages=(page_virt*)malloc(sizeof(page_virt)*nb_pages_phys);
	allocated_pages_capacity=nb_pages_phys;
	for(i=0;i<nb_pages_phys;i++){
		allocated_pages[i]=INVALID;
	}

	allocated_pages_size = 0;

}

void unloadAPage();
void loadAPage(page_virt pv);

void page_fault_handler(page_virt pv){

	// Get a Free block
	if(pm_isFull()){
		printf("PF: Unload a page\n");
		unloadAPage();
	}
	page_phys pp = pm_getFreePage();

	// Mark page as loaded
	printf("PF: Load a page (%d)\n",pv);
	loadAPage(pv);

	// Read from Swap
	if(page_table[pv].status == SWAPPED){
		swap_read(pv,pp);
	}

	// Update page table
	page_table[pv].pp=pp;
	page_table[pv].status=ALLOCATED;

	// Write to MMU
	mmu_addTranslation(pv,pp);

	// That's all
}

#ifdef POLICY_FIFO
void unloadAPage(){
    printf("Page désallouée : %d\n", allocated_pages_first);

    //Trouve la page virtuelle associée
    int page_virt = allocated_pages[allocated_pages_first];

    // Vérifie si modification de la page
    if(mmu_isDirty(page_virt))
    {
   		swap_write(page_virt,page_table[page_virt].pp);
    }

    page_table[page_virt].status = SWAPPED;

    // Désalloue la page physique
    allocated_pages[allocated_pages_first]=INVALID;
    pm_freePage(page_table[page_virt].pp);

    // Invalide la traduction
    mmu_invalidatePage(page_virt);
}

void loadAPage(page_virt pv){
    // Incremente l'indice de la première page
    allocated_pages[allocated_pages_first++] = pv;

    // Remet à 0 quand atteind capacity
    allocated_pages_first = allocated_pages_first % allocated_pages_capacity;
}
#endif

#ifdef POLICY_RANDOM
void unloadAPage(){
	// Génère un nombre aléatoire entre 0 et le nb de pages physiques
	int page_phy = rand() % allocated_pages_capacity;

	printf("Page désallouée : %d\n", page_phy);

	//Trouve la page virtuelle associée
	int page_vir = allocated_pages[page_phy];

	// Vérifie si la page a été modifiée
	if(mmu_isDirty(page_vir)){
		swap_write(page_vir,page_table[page_vir].pp);
	}

	page_table[page_vir].status=SWAPPED;

	// Désalloue la page physique
	allocated_pages[page_phy] = INVALID;
	pm_freePage(page_table[page_vir].pp);

	// Invalide la traduction
	mmu_invalidatePage(page_vir);

	// Mémorise la page libére
	allocated_pages_size = page_phy;
}

void loadAPage(page_virt pv){
	// Incrémente l'indice pour gérer les cas de plusieurs load consécutifs
	allocated_pages[allocated_pages_size++] = pv;
}
#endif

#ifdef POLICY_CLOCK
void unloadAPage(){

	int page_vir;

	bool trouve = 0;

	while(!trouve){
		//Trouve la page virtuelle associée
		int page_vir = allocated_pages[allocated_pages_first];

		// a compléter
	}

	printf("Page désallouée : %d\n", page_phy);

	// Vérifie si la page a été modifiée
	if(mmu_isDirty(page_vir)){
		swap_write(page_vir,page_table[page_vir].pp);
	}

	page_table[page_vir].status=SWAPPED;

	// Désalloue la page physique
	allocated_pages[allocated_pages_first] = INVALID;
	pm_freePage(page_table[page_vir].pp);

	// Invalide la traduction
	mmu_invalidatePage(page_vir);

	// Mémorise la page libére
	allocated_pages_size = page_phy;
}

void loadAPage(page_virt pv){
	// Incremente l'indice de la première page
    allocated_pages[allocated_pages_first++] = pv;

    // Remet à 0 quand atteind capacity
    allocated_pages_first = allocated_pages_first % allocated_pages_capacity;
}
#endif


