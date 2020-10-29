import yargs from 'yargs/yargs';
import { Argv } from 'yargs';
// import { hideBin } from 'yargs/helpers';


type Command = { type: 'version' } | { type: 'bad-usage' };


const getParser = (argv: string[]): Argv => {
    return yargs(argv)
    .help()
    .alias('help', 'h')
    .showHelpOnFail(false);  

}
export const parseArgs = (argv: string[]): Command => {
    const options = getParser(argv).argv;

    if (options.version) {
        return { type: 'version'};
    }
    return { type: 'bad-usage' };
};

export const showUsage = () => {
    const options = getParser([]).showHelp();
}
