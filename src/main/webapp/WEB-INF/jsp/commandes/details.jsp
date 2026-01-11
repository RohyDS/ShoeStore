<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<jsp:include page="../common/header.jsp" />

<body class="h-screen flex overflow-hidden bg-gray-50">
    <jsp:include page="../common/sidebar.jsp" />

    <div class="flex-1 flex flex-col overflow-hidden transition-all duration-300">
        <jsp:include page="../common/navbar.jsp" />

        <main class="flex-1 overflow-x-hidden overflow-y-auto bg-gray-50 p-6">
            <div class="container mx-auto max-w-7xl">
                
                <div class="mb-8 flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
                    <div>
                        <h1 class="text-2xl font-bold text-gray-900 mb-2">Détails de la Commande #${commande.id}</h1>
                        <nav class="flex" aria-label="Breadcrumb">
                            <ol class="inline-flex items-center space-x-1 md:space-x-2">
                                <li class="inline-flex items-center">
                                    <a href="/commandes" class="text-sm font-medium text-gray-500 hover:text-brand-600 transition-colors">Commandes</a>
                                </li>
                                <li>
                                    <div class="flex items-center">
                                        <svg class="w-5 h-5 text-gray-400" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z" clip-rule="evenodd"></path></svg>
                                        <span class="ml-1 text-sm font-medium text-gray-500 md:ml-2">Détails</span>
                                    </div>
                                </li>
                            </ol>
                        </nav>
                    </div>
                </div>

                <div class="bg-white rounded-xl shadow-sm border border-gray-200 overflow-hidden mb-8">
                    <div class="p-6 border-b border-gray-100">
                        <h2 class="text-lg font-semibold text-gray-900">Informations Client</h2>
                    </div>
                    <div class="p-6 grid grid-cols-1 md:grid-cols-2 gap-6">
                        <div>
                            <p class="text-sm font-medium text-gray-500 uppercase tracking-wider mb-1">Nom du Client</p>
                            <p class="text-lg text-gray-900 font-semibold">${commande.client.nom}</p>
                        </div>
                        <div>
                            <p class="text-sm font-medium text-gray-500 uppercase tracking-wider mb-1">Date de Commande</p>
                            <p class="text-lg text-gray-900 font-semibold">${commande.dateCommande}</p>
                        </div>
                    </div>
                </div>

                <div class="bg-white rounded-xl shadow-sm border border-gray-200 overflow-hidden">
                    <div class="p-6 border-b border-gray-100 flex justify-between items-center">
                        <h2 class="text-lg font-semibold text-gray-900">Articles Commandés</h2>
                    </div>
                    <div class="overflow-x-auto">
                        <table class="min-w-full text-left text-sm whitespace-nowrap">
                            <thead class="bg-gray-50 text-gray-900 font-semibold border-b border-gray-200">
                                <tr>
                                    <th class="px-6 py-4">Produit</th>
                                    <th class="px-6 py-4">Catégorie / Genre</th>
                                    <th class="px-6 py-4">Couleur</th>
                                    <th class="px-6 py-4">Pointure</th>
                                    <th class="px-6 py-4 text-center">Quantité</th>
                                    <th class="px-6 py-4 text-right">Prix Unitaire</th>
                                    <th class="px-6 py-4 text-right">Total</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-gray-100">
                                <c:set var="grandTotal" value="0" />
                                <c:forEach items="${details}" var="detail">
                                    <c:set var="itemTotal" value="${detail.prix * detail.quantite}" />
                                    <c:set var="grandTotal" value="${grandTotal + itemTotal}" />
                                    <tr class="hover:bg-gray-50 transition-colors">
                                        <td class="px-6 py-4">
                                            <div class="font-medium text-gray-900">${detail.chaussuresCouleurPointure.chaussureGenre.chaussure.nom}</div>
                                        </td>
                                        <td class="px-6 py-4">
                                            <span class="px-2.5 py-0.5 rounded-full text-xs font-medium bg-blue-50 text-blue-700">
                                                ${detail.chaussuresCouleurPointure.chaussureGenre.categories.nom}
                                            </span>
                                            <span class="px-2.5 py-0.5 rounded-full text-xs font-medium bg-purple-50 text-purple-700 ml-1">
                                                ${detail.chaussuresCouleurPointure.chaussureGenre.genre.nom}
                                            </span>
                                        </td>
                                        <td class="px-6 py-4 text-gray-600">${detail.chaussuresCouleurPointure.couleur.nom}</td>
                                        <td class="px-6 py-4 text-gray-600">T${detail.chaussuresCouleurPointure.pointure.nom}</td>
                                        <td class="px-6 py-4 text-center text-gray-900 font-medium">${detail.quantite}</td>
                                        <td class="px-6 py-4 text-right text-gray-900">
                                            <fmt:formatNumber value="${detail.prix}" type="currency" currencySymbol="$" />
                                        </td>
                                        <td class="px-6 py-4 text-right font-bold text-brand-600">
                                            <fmt:formatNumber value="${itemTotal}" type="currency" currencySymbol="$" />
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                            <tfoot class="bg-gray-50">
                                <tr>
                                    <td colspan="6" class="px-6 py-4 text-right font-semibold text-gray-900">Total Commande</td>
                                    <td class="px-6 py-4 text-right font-bold text-xl text-brand-600">
                                        <fmt:formatNumber value="${grandTotal}" type="currency" currencySymbol="$" />
                                    </td>
                                </tr>
                            </tfoot>
                        </table>
                    </div>
                </div>

                <div class="mt-8">
                    <a href="/commandes" class="inline-flex items-center gap-2 text-gray-600 hover:text-brand-600 font-medium transition-colors">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18" />
                        </svg>
                        Retour à la liste
                    </a>
                </div>
            </div>
        </main>
    </div>
</body>
</html>
