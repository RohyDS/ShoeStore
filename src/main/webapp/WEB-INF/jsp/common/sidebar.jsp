<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<aside class="w-64 bg-gray-50 border-r border-gray-200 hidden md:flex flex-col h-screen fixed inset-y-0 left-0 z-10">
    <!-- Logo Area -->
    <div class="h-16 flex items-center px-6 border-b border-gray-200 bg-white">
        <div class="flex items-center gap-2 font-semibold text-gray-800 text-lg">
            <div class="w-8 h-8 bg-brand-600 rounded-md flex items-center justify-center text-white">
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-5 h-5">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M21 7.5l-2.25-1.313M21 7.5v2.25m0-2.25l-2.25 1.313M3 7.5l2.25-1.313M3 7.5v2.25m0-2.25l2.25 1.313m0 0l2.25 1.313m0 0v2.25m0-2.25l2.25-1.313m0 0l2.25 1.313m0 0v2.25m0-2.25l2.25-1.313M3 7.5l2.25 1.313m0 0L12 12m0 0l3.75-2.188M12 12v9.75M12 12L8.25 9.812M12 21.75L8.25 19.5m3.75 2.25l3.75-2.25m-3.75 2.25v-9.75M8.25 19.5l-3.75-2.188m0 0V9.812M8.25 19.5V9.812m7.5 9.688l3.75-2.188m0 0V9.812m-3.75 9.688V9.812" />
                </svg>
            </div>
            <span>ShoeStore ERP</span>
        </div>
    </div>

    <!-- Scrollable Navigation -->
    <nav class="flex-1 overflow-y-auto py-4 px-3 space-y-1">
        <!-- Section: Core -->
        <div class="px-3 mb-2 text-xs font-semibold text-gray-400 uppercase tracking-wider">
            Tableau de Bord
        </div>
        <% String activePage = (String) request.getAttribute("activePage"); %>
        
        <a href="/" class="flex items-center gap-3 px-3 py-2 text-sm font-medium rounded-md group transition-all duration-200 <%= "home".equals(activePage) ? "bg-white text-brand-600 shadow-sm ring-1 ring-gray-900/5" : "text-gray-600 hover:bg-gray-100 hover:text-gray-900" %>">
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-5 h-5 transition-colors <%= "home".equals(activePage) ? "text-brand-500" : "text-gray-400 group-hover:text-gray-500" %>">
                <path stroke-linecap="round" stroke-linejoin="round" d="M3.75 6A2.25 2.25 0 016 3.75h2.25A2.25 2.25 0 0110.5 6v2.25a2.25 2.25 0 01-2.25 2.25H6a2.25 2.25 0 01-2.25-2.25V6zM3.75 15.75A2.25 2.25 0 016 13.5h2.25a2.25 2.25 0 012.25 2.25V18a2.25 2.25 0 01-2.25 2.25H6A2.25 2.25 0 013.75 18v-2.25zM13.5 6a2.25 2.25 0 012.25-2.25H18A2.25 2.25 0 0120.25 6v2.25A2.25 2.25 0 0118 10.5h-2.25a2.25 2.25 0 01-2.25-2.25V6zM13.5 15.75a2.25 2.25 0 012.25-2.25H18a2.25 2.25 0 012.25 2.25V18A2.25 2.25 0 0118 20.25h-2.25A2.25 2.25 0 0113.5 18v-2.25z" />
            </svg>
            Accueil
        </a>

        <!-- Section: Operations -->
        <div class="px-3 mt-6 mb-2 text-xs font-semibold text-gray-400 uppercase tracking-wider">
            Gestion Stock
        </div>
        
        <a href="/chaussures" class="flex items-center gap-3 px-3 py-2 text-sm font-medium rounded-md group transition-all duration-200 <%= "chaussures".equals(activePage) ? "bg-white text-brand-600 shadow-sm ring-1 ring-gray-900/5" : "text-gray-600 hover:bg-gray-100 hover:text-gray-900" %>">
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-5 h-5 transition-colors <%= "chaussures".equals(activePage) ? "text-brand-500" : "text-gray-400 group-hover:text-gray-500" %>">
                <path stroke-linecap="round" stroke-linejoin="round" d="M21 7.5l-9-5.25L3 7.5m18 0l-9 5.25m9-5.25v9l-9 5.25M3 7.5l9 5.25M3 7.5v9l9 5.25" />
            </svg>
            Chaussures
        </a>

        <a href="/stock" class="flex items-center gap-3 px-3 py-2 text-sm font-medium rounded-md group transition-all duration-200 <%= "stock".equals(activePage) ? "bg-white text-brand-600 shadow-sm ring-1 ring-gray-900/5" : "text-gray-600 hover:bg-gray-100 hover:text-gray-900" %>">
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-5 h-5 transition-colors <%= "stock".equals(activePage) ? "text-brand-500" : "text-gray-400 group-hover:text-gray-500" %>">
                <path stroke-linecap="round" stroke-linejoin="round" d="M8.25 18.75a1.5 1.5 0 01-3 0m3 0a1.5 1.5 0 00-3 0m3 0h6m-9 0H3.375a1.125 1.125 0 01-1.125-1.125V14.25m17.25 4.5a1.5 1.5 0 01-3 0m3 0a1.5 1.5 0 00-3 0m3 0h1.125c.621 0 1.129-.504 1.129-1.125V3.375c0-.621-.508-1.125-1.129-1.125H3.375c-.621 0-1.125.504-1.125 1.125v1.5m17.25 1.5v3m-17.25-3v3m17.25 3v3m-17.25-3v3M6.75 12h10.5m-10.5 3h10.5m-10.5-6h10.5m-10.5 3h10.5" />
            </svg>
            Stock
        </a>

        <!-- Section: Ventes -->
        <div class="px-3 mt-6 mb-2 text-xs font-semibold text-gray-400 uppercase tracking-wider">
            Ventes
        </div>

        <a href="/commandes" class="flex items-center gap-3 px-3 py-2 text-sm font-medium rounded-md group transition-all duration-200 <%= "commandes".equals(activePage) ? "bg-white text-brand-600 shadow-sm ring-1 ring-gray-900/5" : "text-gray-600 hover:bg-gray-100 hover:text-gray-900" %>">
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-5 h-5 transition-colors <%= "commandes".equals(activePage) ? "text-brand-500" : "text-gray-400 group-hover:text-gray-500" %>">
                <path stroke-linecap="round" stroke-linejoin="round" d="M15.75 10.5V6a3.75 3.75 0 10-7.5 0v4.5m11.356-1.993l1.263 12c.07.665-.45 1.243-1.119 1.243H4.25a1.125 1.125 0 01-1.119-1.243l1.263-12c.056-.53.505-.933 1.037-.933h12.726c.532 0 .976.403 1.037.933z" />
            </svg>
            Commandes
        </a>

        <a href="/clients" class="flex items-center gap-3 px-3 py-2 text-sm font-medium rounded-md group transition-all duration-200 <%= "clients".equals(activePage) ? "bg-white text-brand-600 shadow-sm ring-1 ring-gray-900/5" : "text-gray-600 hover:bg-gray-100 hover:text-gray-900" %>">
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-5 h-5 transition-colors <%= "clients".equals(activePage) ? "text-brand-500" : "text-gray-400 group-hover:text-gray-500" %>">
                <path stroke-linecap="round" stroke-linejoin="round" d="M15 19.128a9.38 9.38 0 002.625.372 9.337 9.337 0 004.121-.952 4.125 4.125 0 00-3.833-6.242 4.125 4.125 0 00-3.833 6.242zm-8.906-4.43l.024-.03a5.996 5.996 0 000 8.862m.013-10.962a3.75 3.75 0 110 7.5 3.75 3.75 0 010-7.5zm9.423 3.15a2.25 2.25 0 114.5 0 2.25 2.25 0 01-4.5 0zM2.25 12a13.122 13.122 0 010-4.5m0 4.5c.013.15.027.3.041.45m-.041-.45a13.122 13.122 0 000-4.5M2.25 12c.396 3.081 1.391 5.946 2.875 8.441m.013-10.962l.024-.03m0 0a5.99 5.99 0 014.353-1.92m-4.377 1.95a11.954 11.954 0 011.616-2.483m1.447-4.454a11.978 11.978 0 013.596-3.615m-1.447 4.454a5.981 5.981 0 011.196-.304m0 0a5.99 5.99 0 014.353 1.92m0 0a11.962 11.962 0 011.616 2.483m-4.445-4.403a11.988 11.988 0 00-3.596 3.615m0 0a5.981 5.981 0 00-1.196.304" />
            </svg>
            Clients
        </a>

        <!-- Section: Public Interface -->
        <div class="px-3 mt-6 mb-2 text-xs font-semibold text-gray-400 uppercase tracking-wider">
            Interface Client
        </div>

        <a href="/clientAffichage" target="_blank" class="flex items-center gap-3 px-3 py-2 text-sm font-medium rounded-md group transition-all duration-200 text-brand-600 hover:bg-brand-50">
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-5 h-5 text-brand-500">
                <path stroke-linecap="round" stroke-linejoin="round" d="M13.5 6H5.25A2.25 2.25 0 003 8.25v10.5A2.25 2.25 0 005.25 21h10.5A2.25 2.25 0 0018 18.75V10.5m-10.5 6L21 3m0 0h-5.25M21 3v5.25" />
            </svg>
            Boutique Client
        </a>

        <!-- Section: Configuration -->
        <div class="px-3 mt-6 mb-2 text-xs font-semibold text-gray-400 uppercase tracking-wider">
            Configuration
        </div>

        <a href="/chaussures-variantes" class="flex items-center gap-3 px-3 py-2 text-sm font-medium rounded-md group transition-all duration-200 <%= "variantes".equals(activePage) ? "bg-white text-brand-600 shadow-sm ring-1 ring-gray-900/5" : "text-gray-600 hover:bg-gray-100 hover:text-gray-900" %>">
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-5 h-5 transition-colors <%= "variantes".equals(activePage) ? "text-brand-500" : "text-gray-400 group-hover:text-gray-500" %>">
                <path stroke-linecap="round" stroke-linejoin="round" d="M9.594 3.94c.09-.542.56-.94 1.11-.94h2.593c.55 0 1.02.398 1.11.94l.213 1.281c.063.374.313.686.645.87.074.04.147.083.22.127.324.196.72.257 1.075.124l1.217-.456a1.125 1.125 0 011.37.49l1.296 2.247a1.125 1.125 0 01-.26 1.431l-1.003.827c-.293.24-.438.613-.431.992a6.759 6.759 0 010 .255c-.007.378.138.75.43.99l1.005.828c.424.35.534.954.26 1.43l-1.298 2.247a1.125 1.125 0 01-1.369.491l-1.217-.456c-.355-.133-.75-.072-1.076.124a6.57 6.57 0 01-.22.128c-.331.183-.581.495-.644.869l-.213 1.28c-.09.543-.56.941-1.11.941h-2.594c-.55 0-1.02-.398-1.11-.94l-.213-1.281c-.062-.374-.312-.686-.644-.87a6.52 6.52 0 01-.22-.127c-.325-.196-.72-.257-1.076-.124l-1.217.456a1.125 1.125 0 01-1.369-.49l-1.297-2.247a1.125 1.125 0 01.26-1.431l1.004-.827c.292-.24.437-.613.43-.992a6.932 6.932 0 010-.255c.007-.378-.138-.75-.43-.99l-1.004-.828a1.125 1.125 0 01-.26-1.43l1.297-2.247a1.125 1.125 0 011.37-.491l1.216.456c.356.133.751.072 1.076-.124.072-.044.146-.087.22-.128.332-.183.582-.495.644-.869l.214-1.281z" />
                <path stroke-linecap="round" stroke-linejoin="round" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
            </svg>
            Variantes
        </a>

        <a href="/chaussures-genres" class="flex items-center gap-3 px-3 py-2 text-sm font-medium rounded-md group transition-all duration-200 <%= "chaussuresGenres".equals(activePage) ? "bg-white text-brand-600 shadow-sm ring-1 ring-gray-900/5" : "text-gray-600 hover:bg-gray-100 hover:text-gray-900" %>">
            <span class="w-5 text-center text-xs font-bold <%= "chaussuresGenres".equals(activePage) ? "text-brand-500" : "text-gray-400 group-hover:text-gray-500" %>">CGR</span>
            Chaussures Genres
        </a>

        <a href="/categories" class="flex items-center gap-3 px-3 py-2 text-sm font-medium rounded-md group transition-all duration-200 <%= "categories".equals(activePage) ? "bg-white text-brand-600 shadow-sm ring-1 ring-gray-900/5" : "text-gray-600 hover:bg-gray-100 hover:text-gray-900" %>">
            <span class="w-5 text-center text-xs font-bold <%= "categories".equals(activePage) ? "text-brand-500" : "text-gray-400 group-hover:text-gray-500" %>">CAT</span>
            Catégories
        </a>

        <a href="/marque" class="flex items-center gap-3 px-3 py-2 text-sm font-medium rounded-md group transition-all duration-200 <%= "marque".equals(activePage) ? "bg-white text-brand-600 shadow-sm ring-1 ring-gray-900/5" : "text-gray-600 hover:bg-gray-100 hover:text-gray-900" %>">
            <span class="w-5 text-center text-xs font-bold <%= "marque".equals(activePage) ? "text-brand-500" : "text-gray-400 group-hover:text-gray-500" %>">MRQ</span>
            Marques
        </a>

        <a href="/coupe" class="flex items-center gap-3 px-3 py-2 text-sm font-medium rounded-md group transition-all duration-200 <%= "coupe".equals(activePage) ? "bg-white text-brand-600 shadow-sm ring-1 ring-gray-900/5" : "text-gray-600 hover:bg-gray-100 hover:text-gray-900" %>">
            <span class="w-5 text-center text-xs font-bold <%= "coupe".equals(activePage) ? "text-brand-500" : "text-gray-400 group-hover:text-gray-500" %>">CPE</span>
            Coupes
        </a>

        <a href="/genre" class="flex items-center gap-3 px-3 py-2 text-sm font-medium rounded-md group transition-all duration-200 <%= "genre".equals(activePage) ? "bg-white text-brand-600 shadow-sm ring-1 ring-gray-900/5" : "text-gray-600 hover:bg-gray-100 hover:text-gray-900" %>">
            <span class="w-5 text-center text-xs font-bold <%= "genre".equals(activePage) ? "text-brand-500" : "text-gray-400 group-hover:text-gray-500" %>">GNR</span>
            Genres
        </a>

        <a href="/pointure" class="flex items-center gap-3 px-3 py-2 text-sm font-medium rounded-md group transition-all duration-200 <%= "pointure".equals(activePage) ? "bg-white text-brand-600 shadow-sm ring-1 ring-gray-900/5" : "text-gray-600 hover:bg-gray-100 hover:text-gray-900" %>">
            <span class="w-5 text-center text-xs font-bold <%= "pointure".equals(activePage) ? "text-brand-500" : "text-gray-400 group-hover:text-gray-500" %>">PNT</span>
            Pointures
        </a>

        <a href="/couleur" class="flex items-center gap-3 px-3 py-2 text-sm font-medium rounded-md group transition-all duration-200 <%= "couleur".equals(activePage) ? "bg-white text-brand-600 shadow-sm ring-1 ring-gray-900/5" : "text-gray-600 hover:bg-gray-100 hover:text-gray-900" %>">
            <span class="w-5 text-center text-xs font-bold <%= "couleur".equals(activePage) ? "text-brand-500" : "text-gray-400 group-hover:text-gray-500" %>">CLR</span>
            Couleurs
        </a>

        <a href="/remise" class="flex items-center gap-3 px-3 py-2 text-sm font-medium rounded-md group transition-all duration-200 <%= "remise".equals(activePage) ? "bg-white text-brand-600 shadow-sm ring-1 ring-gray-900/5" : "text-gray-600 hover:bg-gray-100 hover:text-gray-900" %>">
            <span class="w-5 text-center text-xs font-bold <%= "remise".equals(activePage) ? "text-brand-500" : "text-gray-400 group-hover:text-gray-500" %>">%</span>
            Remises
        </a>

        <div class="px-3 mt-6 mb-2 text-xs font-semibold text-gray-400 uppercase tracking-wider">
            Livraison
        </div>

        <a href="/lieu" class="flex items-center gap-3 px-3 py-2 text-sm font-medium rounded-md group transition-all duration-200 <%= "lieu".equals(activePage) ? "bg-white text-brand-600 shadow-sm ring-1 ring-gray-900/5" : "text-gray-600 hover:bg-gray-100 hover:text-gray-900" %>">
            <span class="w-5 text-center text-xs font-bold <%= "lieu".equals(activePage) ? "text-brand-500" : "text-gray-400 group-hover:text-gray-500" %>">LIE</span>
            Lieux
        </a>

        <a href="/frais-livraison" class="flex items-center gap-3 px-3 py-2 text-sm font-medium rounded-md group transition-all duration-200 <%= "fraisLivraison".equals(activePage) ? "bg-white text-brand-600 shadow-sm ring-1 ring-gray-900/5" : "text-gray-600 hover:bg-gray-100 hover:text-gray-900" %>">
            <span class="w-5 text-center text-xs font-bold <%= "fraisLivraison".equals(activePage) ? "text-brand-500" : "text-gray-400 group-hover:text-gray-500" %>">FRS</span>
            Frais Livraison
        </a>
    </nav>
    
    <!-- User Footer -->
    <div class="border-t border-gray-200 p-4">
        <div class="flex items-center gap-3">
            <div class="w-9 h-9 rounded-full bg-gray-200 flex items-center justify-center text-gray-500 font-bold">
                A
            </div>
            <div class="flex-1 min-w-0">
                <p class="text-sm font-medium text-gray-900 truncate">Admin User</p>
                <p class="text-xs text-gray-500 truncate">admin@esky.com</p>
            </div>
        </div>
    </div>
</aside>
