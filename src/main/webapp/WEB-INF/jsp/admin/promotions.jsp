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
                <div class="flex justify-between items-center mb-8">
                    <div>
                        <h1 class="text-2xl font-bold text-gray-900 mb-2">Gestion des Promotions</h1>
                        <nav class="flex" aria-label="Breadcrumb">
                            <ol class="inline-flex items-center space-x-1 md:space-x-2">
                                <li class="inline-flex items-center">
                                    <a href="/" class="inline-flex items-center text-sm font-medium text-gray-500 hover:text-indigo-600">
                                        Accueil
                                    </a>
                                </li>
                                <li>
                                    <div class="flex items-center">
                                        <svg class="w-5 h-5 text-gray-400" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z" clip-rule="evenodd"></path></svg>
                                        <span class="ml-1 text-sm font-medium text-gray-500 md:ml-2">Promotions</span>
                                    </div>
                                </li>
                            </ol>
                        </nav>
                    </div>
                </div>

                <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
                    <!-- Formulaire d'ajout -->
                    <div class="lg:col-span-1">
                        <div class="bg-white rounded-3xl shadow-xl border border-gray-100 p-8">
                            <h2 class="text-xl font-bold text-gray-900 mb-6">Ajouter une promotion</h2>
                            <form action="/admin/promotions/save" method="POST" class="space-y-4">
                                <div>
                                    <label class="block text-sm font-bold text-gray-700 mb-1">Nom de l'événement</label>
                                    <input type="text" name="nom" required placeholder="Ex: Saint Valentin"
                                           class="w-full px-4 py-2 rounded-xl border border-gray-200 focus:ring-2 focus:ring-indigo-500 outline-none transition-all">
                                </div>
                                <div>
                                    <label class="block text-sm font-bold text-gray-700 mb-1">Article concerné</label>
                                    <select name="chaussureGenre.id" required
                                            class="w-full px-4 py-2 rounded-xl border border-gray-200 focus:ring-2 focus:ring-indigo-500 outline-none transition-all">
                                        <c:forEach items="${chaussureGenres}" var="cg">
                                            <option value="${cg.id}">${cg.chaussure.nom} - ${cg.genre.nom} (${cg.categories.nom})</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div>
                                    <label class="block text-sm font-bold text-gray-700 mb-1">Remise (%)</label>
                                    <input type="number" step="0.01" name="remise" required placeholder="Ex: 70"
                                           class="w-full px-4 py-2 rounded-xl border border-gray-200 focus:ring-2 focus:ring-indigo-500 outline-none transition-all">
                                </div>
                                <div>
                                    <label class="block text-sm font-bold text-gray-700 mb-1">Date de début</label>
                                    <input type="datetime-local" name="dateDebutStr" required
                                           class="w-full px-4 py-2 rounded-xl border border-gray-200 focus:ring-2 focus:ring-indigo-500 outline-none transition-all">
                                </div>
                                <div>
                                    <label class="block text-sm font-bold text-gray-700 mb-1">Date de fin</label>
                                    <input type="datetime-local" name="dateFinStr" required
                                           class="w-full px-4 py-2 rounded-xl border border-gray-200 focus:ring-2 focus:ring-indigo-500 outline-none transition-all">
                                </div>
                                <button type="submit" 
                                        class="w-full py-3 bg-indigo-600 text-white font-bold rounded-xl hover:bg-indigo-700 transition-all shadow-lg shadow-indigo-200">
                                    Enregistrer la promotion
                                </button>
                            </form>
                        </div>
                    </div>

                    <!-- Liste des promotions -->
                    <div class="lg:col-span-2">
                        <div class="bg-white rounded-3xl shadow-xl border border-gray-100 overflow-hidden">
                            <div class="p-8 border-b border-gray-100 bg-gray-50/50">
                                <h2 class="text-xl font-bold text-gray-900">Promotions existantes</h2>
                            </div>
                            <div class="overflow-x-auto">
                                <table class="w-full text-left">
                                    <thead>
                                        <tr class="text-xs font-bold text-gray-400 uppercase tracking-widest bg-gray-50">
                                            <th class="py-4 px-6">Événement</th>
                                            <th class="py-4 px-6">Article</th>
                                            <th class="py-4 px-6 text-center">Remise</th>
                                            <th class="py-4 px-6">Période</th>
                                            <th class="py-4 px-6 text-right">Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody class="divide-y divide-gray-100">
                                        <c:forEach items="${promotions}" var="p">
                                            <tr class="hover:bg-gray-50 transition-all">
                                                <td class="py-4 px-6">
                                                    <span class="font-bold text-gray-900">${p.nom}</span>
                                                </td>
                                                <td class="py-4 px-6">
                                                    <div class="text-sm">
                                                        <p class="font-medium text-gray-800">${p.chaussureGenre.chaussure.nom}</p>
                                                        <p class="text-xs text-gray-400">${p.chaussureGenre.genre.nom} - ${p.chaussureGenre.categories.nom}</p>
                                                    </div>
                                                </td>
                                                <td class="py-4 px-6 text-center">
                                                    <span class="px-3 py-1 bg-red-50 text-red-600 rounded-full font-black text-xs">
                                                        -${p.remise}%
                                                    </span>
                                                </td>
                                                <td class="py-4 px-6">
                                                    <div class="text-[10px] space-y-1">
                                                        <p class="text-gray-500">Du: <span class="font-bold text-gray-700">
                                                            <fmt:parseDate value="${p.dateDebut}" pattern="yyyy-MM-dd'T'HH:mm" var="d" type="both" />
                                                            <fmt:formatDate value="${d}" pattern="dd/MM/yyyy HH:mm" />
                                                        </span></p>
                                                        <p class="text-gray-500">Au: <span class="font-bold text-gray-700">
                                                            <fmt:parseDate value="${p.dateFin}" pattern="yyyy-MM-dd'T'HH:mm" var="f" type="both" />
                                                            <fmt:formatDate value="${f}" pattern="dd/MM/yyyy HH:mm" />
                                                        </span></p>
                                                    </div>
                                                </td>
                                                <td class="py-4 px-6 text-right">
                                                    <a href="/admin/promotions/delete/${p.id}" 
                                                       onclick="return confirm('Supprimer cette promotion ?')"
                                                       class="text-red-400 hover:text-red-600 transition-all">
                                                        <svg class="w-5 h-5 ml-auto" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16" />
                                                        </svg>
                                                    </a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </main>
    </div>
</body>
</html>
