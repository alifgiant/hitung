{{flutter_js}}
{{flutter_build_config}}

_flutter.loader.load({
    onEntrypointLoaded: async function(engineInitializer) {
        const appRunner = await engineInitializer.initializeEngine();
    
        var loading = document.querySelector('#loading');
        if (loading) loading.remove();
        await appRunner.runApp();
    }
});