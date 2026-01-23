<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<jsp:include page="../common/header.jsp" />

<body class="h-screen flex overflow-hidden bg-gray-50">
    <!-- Sidebar -->
    <jsp:include page="../common/sidebar.jsp" />

    <!-- Main Content Wrapper -->
    <div class="flex-1 flex flex-col overflow-hidden transition-all duration-300">
        <!-- Top Navbar -->
        <jsp:include page="../common/navbar.jsp" />

        <!-- Main Page Content -->
        <main class="flex-1 overflow-x-hidden overflow-y-auto bg-gray-50 p-6">
            <div class="container mx-auto max-w-7xl">
                
                <!-- Page Header -->
                <div class="mb-8">
                    <h1 class="text-2xl font-bold text-gray-900 mb-2">Analyse du Chiffre d'Affaires</h1>
                    <nav class="flex" aria-label="Breadcrumb">
                        <ol class="inline-flex items-center space-x-1 md:space-x-2">
                            <li class="inline-flex items-center">
                                <a href="/" class="inline-flex items-center text-sm font-medium text-gray-500 hover:text-brand-600">
                                    <svg class="w-4 h-4 mr-1" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path d="M10.707 2.293a1 1 0 00-1.414 0l-7 7a1 1 0 001.414 1.414L4 10.414V17a1 1 0 001 1h2a1 1 0 001-1v-2a1 1 0 011-1h2a1 1 0 011 1v2a1 1 0 001 1h2a1 1 0 001-1v-6.586l.293.293a1 1 0 001.414-1.414l-7-7z"></path></svg>
                                    Accueil
                                </a>
                            </li>
                            <li>
                                <div class="flex items-center">
                                    <svg class="w-5 h-5 text-gray-400" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z" clip-rule="evenodd"></path></svg>
                                    <span class="ml-1 text-sm font-medium text-gray-500 md:ml-2">Analyse CA</span>
                                </div>
                            </li>
                        </ol>
                    </nav>
                </div>

                <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-12">
                    <!-- CA Brut -->
                    <div class="bg-white p-6 rounded-2xl shadow-sm border border-gray-100">
                        <p class="text-xs font-bold text-gray-500 uppercase tracking-wider mb-2">CA Brut (Avant retours)</p>
                        <p class="text-2xl font-black text-gray-900"><fmt:formatNumber value="${caBrut}" pattern="#,##0.00" /> Ar</p>
                    </div>

                    <!-- CA Perdu (Retours) -->
                    <div class="bg-white p-6 rounded-2xl shadow-sm border border-red-100">
                        <p class="text-xs font-bold text-red-500 uppercase tracking-wider mb-2">CA Perdu (Retours)</p>
                        <p class="text-2xl font-black text-red-600">- <fmt:formatNumber value="${caPerdu}" pattern="#,##0.00" /> Ar</p>
                    </div>

                    <!-- CA Net -->
                    <div class="bg-white p-6 rounded-2xl shadow-sm border border-brand-100 bg-brand-50">
                        <p class="text-xs font-bold text-brand-600 uppercase tracking-wider mb-2">CA Net (Après retours)</p>
                        <p class="text-2xl font-black text-brand-700"><fmt:formatNumber value="${caNet}" pattern="#,##0.00" /> Ar</p>
                    </div>
                </div>

                <div class="bg-white rounded-3xl shadow-xl border border-gray-100 overflow-hidden">
                    <div class="p-8 border-b border-gray-100">
                        <h2 class="text-xl font-bold text-gray-900 mb-4">Mise en évidence de l'écart</h2>
                        <div class="flex items-center gap-4">
                            <div class="flex-1 bg-gray-100 h-4 rounded-full overflow-hidden">
                                <div class="bg-red-500 h-full" style="width: ${ecartPourcentage}%"></div>
                            </div>
                            <span class="text-lg font-black text-red-600">${ecartPourcentage}%</span>
                        </div>
                        <p class="text-sm text-gray-500 mt-4 italic">
                            L'écart généré par les retours représente <fmt:formatNumber value="${ecart}" pattern="#,##0.00" /> Ar, soit une diminution de ${ecartPourcentage}% du chiffre d'affaires initial.
                        </p>
                    </div>

                    <div class="p-8 bg-gray-50">
                        <h3 class="text-lg font-bold text-gray-900 mb-6">Liste des articles retournés</h3>
                        <div class="overflow-x-auto">
                            <table class="w-full text-left border-separate border-spacing-y-2">
                                <thead>
                                    <tr class="text-xs font-bold text-gray-400 uppercase tracking-widest">
                                        <th class="pb-4 px-6">Date Retour</th>
                                        <th class="pb-4 px-6">Client</th>
                                        <th class="pb-4 px-6">Article</th>
                                        <th class="pb-4 px-6 text-center">Quantité</th>
                                        <th class="pb-4 px-6 text-right">Montant Remboursé</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${retours}" var="retour">
                                        <tr class="group bg-white hover:bg-gray-50 transition-all duration-200 shadow-sm">
                                            <td class="py-5 px-6 rounded-l-2xl border-y border-l border-gray-100">
                                                <div class="flex items-center gap-3">
                                                    <div class="p-2 bg-indigo-50 text-indigo-600 rounded-lg">
                                                        <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z" />
                                                        </svg>
                                                    </div>
                                                    <span class="text-sm font-medium text-gray-600">
                                                        <fmt:parseDate value="${retour.dateRetour}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDate" type="both" />
                                                        <fmt:formatDate value="${parsedDate}" pattern="dd/MM/yyyy HH:mm" />
                                                    </span>
                                                </div>
                                            </td>
                                            <td class="py-5 px-6 border-y border-gray-100">
                                                <div class="flex items-center gap-3">
                                                    <div class="w-8 h-8 bg-gray-100 rounded-full flex items-center justify-center text-xs font-bold text-gray-500 uppercase">
                                                        ${retour.commandeDetail.commande.client.nom.substring(0,1)}
                                                    </div>
                                                    <span class="text-sm font-bold text-gray-900">${retour.commandeDetail.commande.client.nom}</span>
                                                </div>
                                            </td>
                                            <td class="py-5 px-6 border-y border-gray-100">
                                                <div class="flex flex-col">
                                                    <span class="text-sm font-bold text-gray-900">${retour.commandeDetail.chaussuresCouleurPointure.chaussureGenre.chaussure.nom}</span>
                                                    <div class="flex items-center gap-2 mt-1">
                                                        <span class="text-[10px] px-1.5 py-0.5 bg-gray-100 text-gray-600 rounded font-medium uppercase tracking-wider">${retour.commandeDetail.chaussuresCouleurPointure.couleur.nom}</span>
                                                        <span class="text-[10px] text-gray-400">Pointure ${retour.commandeDetail.chaussuresCouleurPointure.pointure.nom}</span>
                                                    </div>
                                                </div>
                                            </td>
                                            <td class="py-5 px-6 border-y border-gray-100 text-center">
                                                <span class="inline-flex items-center justify-center w-8 h-8 bg-red-50 text-red-700 rounded-full font-bold text-sm">
                                                    ${retour.quantite}
                                                </span>
                                            </td>
                                            <td class="py-5 px-6 rounded-r-2xl border-y border-r border-gray-100 text-right">
                                                <span class="text-sm font-black text-red-600">
                                                    - <fmt:formatNumber value="${retour.montantRembourse}" pattern="#,##0.00" /> Ar
                                                </span>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty retours}">
                                        <tr>
                                            <td colspan="5" class="py-12 text-center">
                                                <div class="flex flex-col items-center gap-3">
                                                    <div class="w-12 h-12 bg-gray-50 rounded-full flex items-center justify-center">
                                                        <svg class="w-6 h-6 text-gray-300" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 13V6a2 2 0 00-2-2H6a2 2 0 00-2 2v7m16 0a2 2 0 01-2 2H6a2 2 0 01-2-2m16 0l-8 8-8-8" />
                                                        </svg>
                                                    </div>
                                                    <span class="text-sm text-gray-400 italic">Aucun retour enregistré pour le moment.</span>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>
</body>
</html>
