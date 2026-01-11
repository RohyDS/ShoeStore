<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="header.jsp" />

<body class="h-screen flex overflow-hidden bg-gray-50">
    <jsp:include page="sidebar.jsp" />

    <div class="flex-1 flex flex-col overflow-hidden transition-all duration-300">
        <jsp:include page="navbar.jsp" />

        <main class="flex-1 overflow-x-hidden overflow-y-auto bg-gray-50 p-6">
            <div class="container mx-auto max-w-7xl">
                <div class="mb-8 flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
                    <div>
                        <h1 class="text-2xl font-bold text-gray-900 mb-2">${title}</h1>
                        <nav class="flex" aria-label="Breadcrumb">
                            <ol class="inline-flex items-center space-x-1 md:space-x-2">
                                <li class="inline-flex items-center text-sm font-medium text-gray-500">Configuration</li>
                                <li>
                                    <div class="flex items-center">
                                        <svg class="w-5 h-5 text-gray-400" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z" clip-rule="evenodd"></path></svg>
                                        <span class="ml-1 text-sm font-medium text-gray-500 md:ml-2">${title}</span>
                                    </div>
                                </li>
                            </ol>
                        </nav>
                    </div>
                    <a href="/${basePath}/nouveau" class="bg-brand-600 text-white px-4 py-2 rounded-md hover:bg-brand-700 shadow-sm transition-colors text-sm font-medium flex items-center gap-2">
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-5 h-5">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M12 4.5v15m7.5-7.5h-15" />
                        </svg>
                        Ajouter
                    </a>
                </div>

                <div class="bg-white rounded-lg shadow-sm border border-gray-200 overflow-hidden">
                    <div class="overflow-x-auto">
                        <table class="min-w-full text-left text-sm whitespace-nowrap">
                            <thead class="bg-gray-50 text-gray-900 font-semibold border-b border-gray-200">
                                <tr>
                                    <th class="px-6 py-3">ID</th>
                                    <th class="px-6 py-3">Nom</th>
                                    <th class="px-6 py-3">Actions</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-gray-100">
                                <c:forEach items="${items}" var="item">
                                    <tr class="hover:bg-gray-50 transition-colors">
                                        <td class="px-6 py-3 text-gray-500">#${item.id}</td>
                                        <td class="px-6 py-3 text-gray-900 font-medium">${item.nom}</td>
                                        <td class="px-6 py-3">
                                            <div class="flex items-center gap-3">
                                                <a href="/${basePath}/modifier/${item.id}" class="text-brand-600 hover:text-brand-700 font-medium">Modifier</a>
                                                <a href="/${basePath}/supprimer/${item.id}" class="text-red-600 hover:text-red-700 font-medium" onclick="return confirm('Supprimer cet élément ?')">Supprimer</a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </main>
    </div>
</body>
</html>
