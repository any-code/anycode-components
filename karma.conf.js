module.exports = function(config) {
    config.set({
        basePath: '',
        frameworks: ['mocha', 'riot'],
        plugins: [
            'karma-mocha',
            'karma-mocha-reporter',
            'karma-phantomjs-launcher',
            'karma-riot'
        ],
        exclude: [
            'node_modules/**/*.tag'
        ],
        files: [
            'node_modules/expect.js/index.js',
            '**/*.tag',
            'test/*.spec.js'
        ],
        preprocessors: {
            '**/*.tag': ['riot']
        },
        browsers: ['PhantomJS'],
        reporters: ['mocha'],
        singleRun: true
    })
}
