export function initSearchPeople() {
    $(document).ready(function() {
        let currentPage = 1;
        let loading = false;
        window.hasMorePeople = true;
    
        // Reset the state
        function resetState() {
        currentPage = 1;
        loading = false;
        window.hasMorePeople = true;
        }
    
        function loadMorePeople() {
        if (!loading && window.hasMorePeople) {
            loading = true;
            currentPage += 1;
    
            let currentSearchParams = new URLSearchParams(window.location.search);
    
            const peopleUrl = $("#search-input").data("people-url");
            currentSearchParams.set('page', currentPage);
            const url = `${peopleUrl}?${currentSearchParams.toString()}`;
    
            $.ajax({
            url: url,
            method: 'GET',
            dataType: 'script',
            success: function(data) {
            },
            error: function(jqXHR, textStatus, errorThrown) {
                console.log('Error:', textStatus, errorThrown);
            },
            complete: function() {
                loading = false;
            }
            });
        }
        }
    
        $(document).on('scroll', function() {
        if ($(window).scrollTop() + $(window).height() >= $("#people-container").height()) {
            loadMorePeople();
        }
        });
    
        $(document).on('submit', '#search-form', function(event) {
        resetState();
        });
    });
}