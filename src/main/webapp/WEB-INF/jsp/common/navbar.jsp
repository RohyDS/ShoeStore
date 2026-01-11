<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<header class="h-16 bg-white border-b border-gray-200 flex items-center justify-between px-6 z-20">
    <!-- Breadcrumbs / Search -->
    <div class="flex items-center gap-4 flex-1">
        <!-- Mobile Menu Button -->
        <button class="md:hidden p-2 text-gray-500 hover:bg-gray-100 rounded-md">
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-6 h-6">
                <path stroke-linecap="round" stroke-linejoin="round" d="M3.75 6.75h16.5M3.75 12h16.5m-16.5 5.25h16.5" />
            </svg>
        </button>

        <!-- ShoeStore Logo -->
        <div class="hidden md:flex items-center gap-2 mr-4 text-brand-600 font-bold text-xl">
             <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-8 h-8">
                <path stroke-linecap="round" stroke-linejoin="round" d="M21 7.5l-9-5.25L3 7.5m18 0l-9 5.25m9-5.25v9l-9 5.25M3 7.5l9 5.25M3 7.5v9l9 5.25" />
            </svg>
            <span>ShoeStore</span>
        </div>

        <!-- Search Bar -->
        <div class="relative w-full max-w-md hidden sm:block">
            <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                <svg class="h-5 w-5 text-gray-400" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                    <path fill-rule="evenodd" d="M9 3.5a5.5 5.5 0 100 11 5.5 5.5 0 000-11zM2 9a7 7 0 1112.452 4.391l3.328 3.329a.75.75 0 11-1.06 1.06l-3.329-3.328A7 7 0 012 9z" clip-rule="evenodd" />
                </svg>
            </div>
            <input type="text" name="search" id="search" class="block w-full pl-10 pr-3 py-2 border border-gray-200 rounded-md leading-5 bg-gray-50 placeholder-gray-500 focus:outline-none focus:placeholder-gray-400 focus:ring-1 focus:ring-brand-500 focus:border-brand-500 sm:text-sm" placeholder="Rechercher (Ctrl+K)">
        </div>
    </div>

    <!-- Right Actions -->
    <div class="flex items-center gap-4">
        <button class="p-2 text-gray-400 hover:text-gray-500 relative">
            <span class="absolute top-2 right-2 h-2 w-2 rounded-full bg-red-500 border-2 border-white"></span>
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-6 h-6">
                <path stroke-linecap="round" stroke-linejoin="round" d="M14.857 17.082a23.848 23.848 0 005.454-1.31A8.967 8.967 0 0118 9.75v-.7V9A6 6 0 006 9v.75a8.967 8.967 0 01-2.312 6.022c1.733.64 3.56 1.085 5.455 1.31m5.714 0a24.255 24.255 0 01-5.714 0m5.714 0a3 3 0 11-5.714 0" />
            </svg>
        </button>
        <div class="h-8 w-px bg-gray-200"></div>
        <button class="text-sm font-medium text-gray-600 hover:text-gray-900">Aide</button>
    </div>
</header>
