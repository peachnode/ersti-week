import Vue from 'vue';
import Vuetify from 'vuetify/lib/framework';

Vue.use(Vuetify);

export default new Vuetify({
    theme: {
        themes: {
            light: {
                flinta: '#abcdef', // your custom colors
                ukraine: '#FFDD00',
                bachelor: '#D21034',
                master: '#FF7E00',
                international: '#593EB6'
            },
        },
    },
});
